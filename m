Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSIEJmV>; Thu, 5 Sep 2002 05:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSIEJmV>; Thu, 5 Sep 2002 05:42:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:28170 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317365AbSIEJmV>; Thu, 5 Sep 2002 05:42:21 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.10250.877661.656133@laputa.namesys.com>
Date: Thu, 5 Sep 2002 13:46:50 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: "David S. Miller" <davem@redhat.com>
Cc: szepe@pinerecords.com, mason@suse.com, reiser@namesys.com,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
In-Reply-To: <20020904.224531.118542066.davem@redhat.com>
References: <20020905054008.GH24323@louise.pinerecords.com>
	<20020904.223651.79770866.davem@redhat.com>
	<20020905054858.GI24323@louise.pinerecords.com>
	<20020904.224531.118542066.davem@redhat.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Emacs-Acronym: Extraneous Macros And Commands Stink
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 >    From: Tomas Szepe <szepe@pinerecords.com>
 >    Date: Thu, 5 Sep 2002 07:48:58 +0200
 >    
 >    And a pretty straightforward one, too. Convert the internal reiserfs
 >    link stuff to an unsigned short, find NLINK_MAX using the code I posted
 >    last night (or maybe simply grab it from userspace includes) and add
 >    a check to your stat() code to return NLINK_MAX if necessary.
 >    
 > Whose stat() code?  These go straight to userspace via normal
 > syscalls.

In 2.5 is goes through ->getattr() method.

 >    
 > It has to be done generically, in the VFS or reiserfs.

Nikita.
