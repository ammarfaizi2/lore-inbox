Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRBMXaO>; Tue, 13 Feb 2001 18:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130212AbRBMXaE>; Tue, 13 Feb 2001 18:30:04 -0500
Received: from adonis.lbl.gov ([128.3.5.144]:8968 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S129419AbRBMX3x>;
	Tue, 13 Feb 2001 18:29:53 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-pre2 ext2fs corruption
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 13 Feb 2001 15:29:50 -0800
Message-ID: <87wvauxitt.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i came in today to find the computer completely locked up. after
rebooting and waiting for about an hour for fsck to finish i found the
following errors in the system log:

Feb 13 06:25:18 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #11: rec_len %% 4 != 0 - offset=0, inode=1179403647, rec_len=257, name_len=1
Feb 13 06:25:18 caliban kernel: init_special_inode: bogus imode (34503)
Feb 13 06:25:18 caliban kernel: init_special_inode: bogus imode (30060)
Feb 13 06:25:18 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #1170: directory entry across blocks - offset=0, inode=842214441, rec_len=11312, name_len=51
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (52073)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (35144)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (71563)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (51117)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (72141)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (52101)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (36451)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (54522)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (30067)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (57505)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (31454)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (71145)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (74105)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (34063)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (51520)
Feb 13 06:25:19 caliban kernel: init_special_inode: bogus imode (72151)
Feb 13 06:25:19 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #16292: rec_len %% 4 != 0 - offset=0, inode=741488945, rec_len=12851, name_len=59
Feb 13 06:25:19 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #16293: rec_len %% 4 != 0 - offset=0, inode=740898354, rec_len=12337, name_len=56

[more of the same deleted]

Feb 13 06:26:23 caliban kernel: init_special_inode: bogus imode (44)
Feb 13 06:26:23 caliban kernel: init_special_inode: bogus imode (104)
Feb 13 06:26:23 caliban kernel: init_special_inode: bogus imode (3)
Feb 13 06:26:23 caliban kernel: init_special_inode: bogus imode (52731)
Feb 13 06:26:23 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #679: rec_len %% 4 != 0 - offset=0, inode=842214450, rec_len=18235, name_len=101
Feb 13 06:26:23 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #827280: rec_len %% 4 != 0 - offset=0, inode=25203, rec_len=25206, name_len=0
Feb 13 06:26:24 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_readdir: bad entry in directory #822: rec_len is too small for name_len - offset=0, inode=32419, rec_len=128, name_len=235

[more of the same deleted]

Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_inode: bit already cleared for inode 18434
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks in system zones - Block = 130, count = 1
Feb 13 06:28:31 caliban kernel: fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 925969465, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 675096887, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 824981816, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1026111543, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 959981610, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 892809516, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1347158057, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 977752909, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 959981684, count = 1
Feb 13 06:28:31 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 959918380, count = 1


[more deleted]

Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks in system zones - Block = 128, count = 1
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: bit already cleared for block 128
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 152502400, count = 1
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 152502400, count = 1
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks in system zones - Block = 128, count = 1
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: bit already cleared for block 128
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=611844612, limit=7116795
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=152961152
Feb 13 06:28:48 caliban kernel: evice sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=579451439
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=1163009752, limit=7116795
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=-782989387
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=1718049480, limit=7116795
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=-1181100367
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=310652652, limit=7116795
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=1151404986
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=874643024, limit=7116795
Feb 13 06:28:48 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18575, block=1829273491
Feb 13 06:28:48 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:48 caliban kernel: 08:03: rw=0, want=1118405292, limit=7116795

[more deleted]

Feb 13 06:28:48 caliban kernel: Kernel panic: EXT2-fs panic (device sd(8,3)): load_block_bitmap: block_group >= groups_count - block_group = 131071, groups_count = 55
Feb 13 06:28:48 caliban kernel: 
Feb 13 06:28:50 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 171442304, count = 1
Feb 13 06:28:50 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 171442304, count = 1
Feb 13 06:28:50 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks in system zones - Block = 128, count = 1

[more deleted]

Feb 13 06:28:50 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:50 caliban kernel: 08:03: rw=0, want=691798532, limit=7116795
Feb 13 06:28:50 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18578, block=172949632
Feb 13 06:28:51 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:51 caliban kernel: 08:03: rw=0, want=617404596, limit=7116795
Feb 13 06:28:51 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18578, block=691222060
Feb 13 06:28:51 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:51 caliban kernel: 08:03: rw=0, want=557922308, limit=7116795
Feb 13 06:28:51 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18578, block=1213222400
Feb 13 06:28:51 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:51 caliban kernel: 08:03: rw=0, want=1489308948, limit=7116795
Feb 13 06:28:51 caliban kernel: EXT2-fs error (device sd(8,3)): ext2_free_branches: Read failure, inode=18578, block=909198148
Feb 13 06:28:51 caliban kernel: attempt to access beyond end of device
Feb 13 06:28:51 caliban kernel: 08:03: rw=0, want=1419890924, limit=7116795

and on and on, about 4000 lines or so. the computer is back up but the
file system is really messed up, with most files containing parts of
other files. is this a known problem? has it been fixed? if somebody
finds it useful i can make the whole log available on my web site.
right now i am running 2.4.2-pre3 but i am thinking of going back to
2.2.18.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
