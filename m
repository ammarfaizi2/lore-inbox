Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTFUTSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbTFUTSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:18:41 -0400
Received: from kuwiserv.folkwang-hochschule.de ([193.175.156.250]:65487 "EHLO
	kuwiserv.folkwang-hochschule.de") by vger.kernel.org with ESMTP
	id S265281AbTFUTSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:18:40 -0400
Message-ID: <3EF4C0CC.6090100@folkwang-hochschule.de>
Date: Sat, 21 Jun 2003 22:32:12 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Reply-To: nettings@folkwang-hochschule.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: severe FS corruption w/ reiserfs and 2.5.72-bk3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a word of warning:

i just completely and utterly trashed my filesystems with 2.5.72-bk2 and 
reiserfs. there are metric shitloads of errors on journal replay and i 
end up in repair mode. did a couple of --rebuild-tree's, but new errors 
cropped up after every reboot.
happens both on scsi and ide drives and ate almost all of my machine...

my reiserfstools are recent (can't recall the version, but it's better 
than or equal to the one listed in Documentation/Changes).

otoh, it seems i had two versions installed, the one that comes with 
suse 8.1 in /sbin/ and mine in /usr/local/sbin. after realizing the 
problem, i moved the current version over to /sbin so that it is invoked 
on startup... might have made the problem worse.

unfortunately i did a number of things at once: upgrade the kernel from 
.72 (which has worked for me quite well), add an ide drive (i didn't 
have ide in my kernel before, and geez! is that module code broken :)) 
and shuffle partitions around. which makes the problem hard to pinpoint.

if anyone wants me to do some forensics on the machine, speak up. 
otherwise i'll swipe it clean and start over from scratch.

best,

jörn


(i'd appreciate a cc: of your replies. thanks.)


-- 
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


Jörn Nettingsmeier
Kurfürstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)


