Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRC0C6p>; Mon, 26 Mar 2001 21:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRC0C6g>; Mon, 26 Mar 2001 21:58:36 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:896 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S130448AbRC0C6W>;
	Mon, 26 Mar 2001 21:58:22 -0500
Date: Mon, 26 Mar 2001 18:57:37 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <174740000.985659658@tiny>
Message-ID: <Pine.LNX.4.21.0103261841240.31038-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Chris Mason wrote:
> On Monday, March 26, 2001 03:21:29 PM -0800 Christoph Lameter
> > On Mon, 26 Mar 2001, Chris Mason wrote:
> >> On Saturday, March 24, 2001 11:56:08 AM -0800 Christoph Lameter
> >> <christoph@lameter.com> wrote:
> >> > I got a directory /a/yy that I tried to erase with rm -rf /a/yy.
> >> > 
> >> > rm hangs...
> >> > 
> >> > ls gives the following output:
> >> > 
> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such
> >> > file or directory
> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such
> >> > file or directory
> >> > 
> >> > and so on and so on....
> >> > 
> >> > I tried a reiserfscheck -x on the /a volume but the strangeness still
> >> > persists. What is going on here?
> >> There should be more messages on the console that will help identify the
> >> problem.  Please check through /var/log/messages and send along anything
> >> that looks odd.
> > 
> > 
> > Yes I see messages like this in the log:
> > 
> > Mar 26 06:47:50 k2-400 kernel: Out of Memory: Killed process 421 (mysqld).
> 
> Hmmm, I was expecting something from reiserfs.  The file not found messages
> from ls usually go along with warnings from reiserfs about an i/o error.
> What does a readonly reiserfsck say (without the -x).

Sorry the HD is ok. Is there any way to get rid of the mess?

output of reiserfsck:

grow_id_map: objectid map expanded: used 1024, 1 blocks
bad_leaf: block 9454 has invalid item 4: 1928 5204 0x1 DIR, len 184, entry count 5, fsck need 0, format old
grow_id_map: objectid map expanded: used 2048, 2 blocks
grow_id_map: objectid map expanded: used 3072, 3 blocks
grow_id_map: objectid map expanded: used 4096, 4 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
grow_id_map: objectid map expanded: used 4096, 4 blocks
shrink_id_map: objectid map shrinked: used 4096, 5 blocks
grow_id_map: objectid map expanded: used 4096, 4 blocks
grow_id_map: objectid map expanded: used 5120, 5 blocks
grow_id_map: objectid map expanded: used 6144, 6 blocks
grow_id_map: objectid map expanded: used 7168, 7 blocks
grow_id_map: objectid map expanded: used 8192, 8 blocks
grow_id_map: objectid map expanded: used 9216, 9 blocks
grow_id_map: objectid map expanded: used 10240, 10 blocks
grow_id_map: objectid map expanded: used 11264, 11 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
grow_id_map: objectid map expanded: used 13312, 13 blocks
shrink_id_map: objectid map shrinked: used 13312, 14 blocks
grow_id_map: objectid map expanded: used 13312, 13 blocks
shrink_id_map: objectid map shrinked: used 13312, 14 blocks
grow_id_map: objectid map expanded: used 13312, 13 blocks
shrink_id_map: objectid map shrinked: used 13312, 14 blocks
grow_id_map: objectid map expanded: used 13312, 13 blocks
shrink_id_map: objectid map shrinked: used 13312, 14 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
shrink_id_map: objectid map shrinked: used 11264, 12 blocks
grow_id_map: objectid map expanded: used 11264, 11 blocks
shrink_id_map: objectid map shrinked: used 11264, 12 blocks
grow_id_map: objectid map expanded: used 11264, 11 blocks
shrink_id_map: objectid map shrinked: used 11264, 12 blocks
grow_id_map: objectid map expanded: used 11264, 11 blocks
shrink_id_map: objectid map shrinked: used 11264, 12 blocks
grow_id_map: objectid map expanded: used 11264, 11 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
grow_id_map: objectid map expanded: used 12288, 12 blocks
shrink_id_map: objectid map shrinked: used 12288, 13 blocks
free block count 447444 mismatches with a correct one 447840. 
on-disk bitmap does not match to the correct one. 
check_semantic_tree: hash mismatch detected (cache3A0F94EA0A00557.html)
check_semantic_tree: name "cache3A0F94EA0A00557.html" in directory 1928 5204 points to nowhere
check_semantic_tree: hash mismatch detected (cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb)
check_semantic_tree: name "cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb" in directory 1928 5204 points to nowhere


