Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291871AbSBHWHs>; Fri, 8 Feb 2002 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSBHWHj>; Fri, 8 Feb 2002 17:07:39 -0500
Received: from dialin-145-254-136-157.arcor-ip.net ([145.254.136.157]:2308
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S291871AbSBHWHU>;
	Fri, 8 Feb 2002 17:07:20 -0500
Date: Fri, 8 Feb 2002 23:07:13 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020208230713.A13545@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com> <20020207104420.A6824@namesys.com> <20020207230235.A173@steel> <20020208085155.A7034@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20020208085155.A7034@namesys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
hmm.. You're demanding too much(mkreiserfs) - it's my home partition :)
And really sorry, i even forgot about reiserfsck it before the patch.
Maybe the corruptions are from previous kernels, but the zero-files
are observed for the first time, particularly in the .bash_history.

And yes, that's the same box (i have no other spare box to
experiment with). The memtest didn't found anything (maybe,
i had it run only 1pass for about 1 hour). The processor
is not overclocked, the cooler is native (sold together with
the processor). But the zero-files was seen in the day before
machine check exceptions were occured.

Sorry for such a dirty test environment, i was really not prepared.
Logs attached.
-alex

On Fri, Feb 08, 2002 at 08:51:55AM +0300, Oleg Drokin wrote:                                        
> these corruptions are not from the previous kernels (particularly                                 
> bad_leaf: block 211482 has wrong order of items record worries me)                                
Also I hope this is not on the same box, where you are getting                                      
Machine Check Exceptions.                                                                           

On Fri, Feb 08, 2002 at 08:51:56AM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Feb 07, 2002 at 11:02:35PM +0100, Alex Riesen wrote:
> 
> > The reiserfsck showed up some nasty looking errors:
> >  shrink_id_map: objectid map shrinked: used 4096, 5 blocks
> >  grow_id_map: objectid map expanded: used 5120, 5 blocks
> >  grow_id_map: objectid map expanded: used 10240, 10 blocks
> >  bad_leaf: block 211482 has wrong order of items
> >  ...more of that...
> >  free block count 1326452 mismatches with a correct one 1326458.
> >  on-disk bitmap does not match to the correct one. 1 bytes differ
> 
> Have you mkreiserfs'ed your partition before testing the patch I've sent you?
> Or have you at least made a reiserfsck before a test run to ensure,
> these corruptions are not from the previous kernels (particularly
> bad_leaf: block 211482 has wrong order of items record worries me)
> 
> > "reiserfsck --rebuild-tree" cured them without visible damages for now.
> > There were some messages about deleted blocks, expanded objectid map,
> > shrinked map and one "dir 1 2 has wrong sd_size 120, has to be 152".
> > I can send you logs, if needed.
> Sure, please do.
> 
> > Does the 2.5.4-pre2 contains this patch ?
> Yes.
> 
> Thank you.
> 
> Bye,
>     Oleg

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hda10.reiserfsck"

shrink_id_map: objectid map shrinked: used 4096, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
bad_leaf: block 211482 has wrong order of items
bad_leaf: block 239020 has wrong order of items
bad_leaf: block 231194 has wrong order of items
bad_leaf: block 231200 has wrong order of items
bad_leaf: block 218992 has wrong order of items
bad_leaf: block 238517 has wrong order of items
bad_leaf: block 238517 has wrong order of items
bad_leaf: block 231802 has wrong order of items
bad_leaf: block 238421 has wrong order of items
bad_leaf: block 268851 has wrong order of items
bad_leaf: block 268924 has wrong order of items
bad_leaf: block 238764 has wrong order of items
bad_leaf: block 268780 has wrong order of items
free block count 1326452 mismatches with a correct one 1326458. 
on-disk bitmap does not match to the correct one. 1 bytes differ

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hda10.reiserfsck-rebuild"

####### Pass 0 #######
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
block 211482: item 3: 642241 785195 0x1 DRCT, len 328, entry count 65535, fsck need 0, format old follows non stat item 642241 783914 0x1 IND, len 32, entry count 0, fsck need 0, format new - deleted
block 218992: item 4: 642259 784628 0x1 DRCT, len 120, entry count 65535, fsck need 0, format old follows non stat item 642259 784257 0x1 IND, len 16, entry count 0, fsck need 0, format new - deleted
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
shrink_id_map: objectid map shrinked: used 14336, 15 blocks
block 231194: item 11: 642253 784595 0x1 DRCT, len 232, entry count 65535, fsck need 0, format old follows non stat item 642253 783908 0x1 IND, len 28, entry count 0, fsck need 0, format new - deleted
block 231200: item 6: 642257 785425 0x1 DRCT, len 112, entry count 65535, fsck need 0, format old follows non stat item 642257 783961 0x2001 DRCT, len 192, entry count 65535, fsck need 0, format new - deleted
block 231802: item 5: 642287 785128 0x1 DRCT, len 80, entry count 65535, fsck need 0, format old follows non stat item 642287 784281 0x1 IND, len 40, entry count 0, fsck need 0, format new - deleted
block 238421: item 12: 642288 784777 0x1 DRCT, len 40, entry count 65535, fsck need 0, format old follows non stat item 642288 781524 0x1 IND, len 12, entry count 0, fsck need 0, format new - deleted
block 238517: item 1: 642282 785146 0x1 DRCT, len 80, entry count 65535, fsck need 0, format old follows non stat item 642282 781483 0x699 DRCT, len 376, entry count 65535, fsck need 0, format new - deleted
block 238517: item 1: 642282 785150 0x1 DRCT, len 344, entry count 65535, fsck need 0, format old follows non stat item 642282 781483 0x699 DRCT, len 376, entry count 65535, fsck need 0, format new - deleted
block 238764: item 7: 645962 785618 0x1 IND, len 8, entry count 0, fsck need 0, format old follows non stat item 645962 785358 0x1 IND, len 572, entry count 0, fsck need 0, format new - deleted
block 239020: item 5: 642245 784614 0x1 DRCT, len 216, entry count 65535, fsck need 0, format old follows non stat item 642245 783963 0x1 IND, len 16, entry count 0, fsck need 0, format new - deleted
block 268780: item 3: 741504 784733 0x1 DRCT, len 312, entry count 65535, fsck need 0, format old follows non stat item 741504 783706 0x1 IND, len 156, entry count 0, fsck need 0, format new - deleted
block 268851: item 1: 642297 785381 0x1 DRCT, len 352, entry count 65535, fsck need 0, format old follows non stat item 642297 785251 0x1 DRCT, len 144, entry count 65535, fsck need 0, format old - deleted
block 268924: item 3: 642298 785473 0x1 DRCT, len 224, entry count 65535, fsck need 0, format old follows non stat item 642298 784199 0x1 IND, len 52, entry count 0, fsck need 0, format new - deleted
"r5" got 247952 hits
####### Pass 1 #######
####### Pass 2 #######
####### Pass 3 #########
grow_id_map: objectid map expanded: used 5120, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
shrink_id_map: objectid map shrinked: used 9216, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
dir 1 2 has wrong sd_size 120, has to be 152
####### Pass 3a (lost+found pass) #########

--OXfL5xGRrasGEqWY--
