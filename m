Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWGXFBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWGXFBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 01:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWGXFBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 01:01:34 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:36298 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751149AbWGXFBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 01:01:33 -0400
Message-ID: <44C44622.9050504@namesys.com>
Date: Sun, 23 Jul 2006 22:01:38 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@lpbproductions.com
CC: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com>
In-Reply-To: <200607230212.55293.lkml@lpbproductions.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Heler wrote:

>On Sunday 23 July 2006 12:20 am, Hans Reiser wrote:
>  
>
>
>The way you wrote this, makes it sound like a userspace issue, and _not_ a 
>problem with reiserfs.
>  
>
It was a problem with reiserfs.  Code was added to search for the
perfect spot to fit a file.  If there is no perfect spot, it searches
every bitmap for that spot before giving up.  However, Jeff kindly gave
us a little patch to fix this and made the whole issue moot.  It also
seems I was in error, and we actually have had this problem since 2002. 
Now some past remarks from users about fragmentation make more sense. 
What can I say, since I have no MP3s I never get anywhere near full on
my personal hard drive.

>  
>
>>And look at how Linus abandoned 2.4!  Users of 2.4 needed so many
>>features that were put into 2.6 instead, and they were just abandoned
>>and neglected and....  Do you think he will abandon 2.6.18 also?
>>    
>>
>
>Not entirely true, he did not abandon the 2.4 kernel branch, he passed on 
>maintainership to Marcelo. Similar to how he passed the torch on the 2.2 
>kernel branch to Alan Cox. Also on a side note, many new features ( and a ton 
>of bug fixes !! ) were added to the 2.4 series _after_ Linus started working 
>on the 2.5 branch.
>  
>
You missed the sarcasm in my voice, my apologies, it is the trouble I
have with email.

Just to balance everything with some nuance, let me add that when a
development branch is first opened, there is usually a bit of gray as to
whether particular small features should go into the development branch
or the stable branch.  As the stable branch gets more stable the
incentive to not destabilize it increases, and as a development branch
becomes usable, the delay to users due to putting features only there
reduces.

I want reiserfs to be the filesystem that professional system
administrators view as the one with both the fastest technological pace,
and the most conservative release management.

I apologize to users  that the technology required a 5 year gap between
releases.   It just did, an outsider may not realize how deep the
changes we made were.  Things like per node locking based on a whole new
approach to tree locking that goes bottom up instead of the usual top
down are big tasks.    Dancing trees are a big change, getting rid of
blobs is a big change, wandering logs.....  We did a lot of things like
that, and got very fortunate with them.  If we had tried to add such
changes to V3, the code would have been unstable the whole 5 years, and
would not have come out right.

Experienced writers know that often, if you want to fix a passage, even
a passage that is quite good in some parts, sometimes it is better to
write the whole passage again without looking at the text of the first
draft of the old passage, because sometimes your muse just needs the
freedom, and without the freedom the awkwardness of the old passage is
incurable.  Probably there is some very sophisticated neurological
reason why that is.  Code can be the same.  Sometimes.  I knew that
reiser4 HAD to be written from scratch without reference to the old code
if it was to come out right. 

If I cannot be a great artist, at least I can try to have the
temperament of one, yes? :-)

I sincerely hope that using mount options to select default plugins, and
making development code go into new plugins means that releases after
this can be roughly quarterly, and that we can start doing a whole bunch
of quick little plugins.  Technically, I think it is going to be
downhill skiing from here, and some very visible bits of functionality
will get added much more easily than this difficult infrastructure we
just coded.

Hans
