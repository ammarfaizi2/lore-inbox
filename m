Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315249AbSEDXbe>; Sat, 4 May 2002 19:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315253AbSEDXbd>; Sat, 4 May 2002 19:31:33 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:56651 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315249AbSEDXbc>; Sat, 4 May 2002 19:31:32 -0400
Subject: [BK-PATCH-2.5.13] mm/memory.c: Don't printk uninitialized variable...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 5 May 2002 00:31:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1748zy-0005jk-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-mm

This will update the following files:

 mm/memory.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/05/05 1.517)
   mm/memory.c:
   - Remove always unused variable page from remap_pte_range().
   - Fix printk in do_wp_page() so it doesn't print out an uninitialized
     variable (old_page). Add KERN_ERR log level while at it.


diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Sun May  5 00:17:07 2002
+++ b/mm/memory.c	Sun May  5 00:17:07 2002
@@ -874,7 +874,6 @@
 		end = PMD_SIZE;
 	pfn = phys_addr >> PAGE_SHIFT;
 	do {
-		struct page *page;
 		pte_t oldpage = ptep_get_and_clear(pte);
 
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
@@ -1043,7 +1042,7 @@
 bad_wp_page:
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
-	printk("do_wp_page: bogus page at address %08lx (page 0x%lx)\n",address,(unsigned long)old_page);
+	printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n", address);
 	return -1;
 no_mem:
 	page_cache_release(old_page);

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020504230705|32338
## Wrapped with gzip_uu ##


begin 664 bkpatch3967
M'XL(`/-KU#P``]U446O;,!!^CG[%T3+6TL61+,N./3+:-=U6.K;BT;=!4&PU
M$;4E(\E)6_SCIR9;$NA8Z>A>9@O$G<[?W7WW6?MP/LYZ3IL%KTI[S-V\TBIP
MABM;"\>#0M?=Z9RKF?@F7!=B'/J7D81B%G<DQE'2%:0DA$=$E#B,AG&$]N'*
M"I/UN.0A\=8G;5W6*[AR?!HHX;PKU]J[!JTU`VN*0255>]L/`]:O:^2/+[DK
MYK`0QF8]$M"-Q]TU(NOE9Q^O/I_D"(U&L*D-1B/TLFULT!JA9JU\`HYA&A(<
M4=;1,,4)&@,)?`+`X0`SOP#C#"<99D>89!C#BISC+2EP1*"/T7MXV29.40%U
M/:A%K<U=4&3>[$/NK84`7BWYG856M5:4L.!&\FDEH.$S`==&UV!$S9M)X\3$
M/&0].`Q6GW^0M]`8J=P-2`6EGBQ]$'\X!ZM!.N\25KUVZR#0K0.N?!JII).\
MDO>B]#BPS7B@JW*%<!C`25G"Q5G^97*6YU#I&51B(2I8SJ4/Y,[#!^@":$CI
M$%UNQX_ZSWP0PARC=T_0O4/=+N$I33N,TS3IV)#1,KV^+BEATRAEC^;Z&(+A
M**0XP;2+"8W92L8[04\+^=E%H7O9-*(Z7O]F=3R\";29_:ZR!PU3&GD<G*XU
M')-'$J9_DG#X3R3\/VAV/>VOT#?+U?(:O-P=_%](>#Q,$B!H["^>V._G/_?>
MNM.#34U[VX8SF.I9:]>,^=IX61IA+;S"P^KVN]I[\\MS^'9[$Q=S4=S8MAYQ
/PC@O(X%^`*]/Z=(X!@``
`
end
