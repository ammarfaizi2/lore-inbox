Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVC2Ty0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVC2Ty0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVC2TyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:54:25 -0500
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:64677 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261350AbVC2Twt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:52:49 -0500
Message-ID: <4249B2B8.1090807@poczta.onet.pl>
Date: Tue, 29 Mar 2005 21:55:36 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFD] 'nice' attribute for executable files
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

recently i had to run some program (xmms) with lowered nice value as 
normal user. to do that i had to su to the root account and then execute 
nice --5 xmms. but, then xmms was run as root and X server refused 
connection, so i had to do second su from root account. (total: su nice 
--5 su wixor xmms). what's more, i thought that entering root password 
each time i want to run something with lowered nice is rather boring. 
furthermore, on many systems root may want to make users able to run 
some program with lowered nice, but not from root account and without 
having to know the root password... i've found a way to do this using 
shell scripts combined with suid bit and strange fils ownerships, but it 
is absolute diseaster.

so i thought that it would be nice to add an attribute to file 
(changable only for root) that would modify nice value of process when 
it starts. if there is one byte free in ext2/3 file metadata, maybe it 
could be used for that? i think that it woundn't be more dangerous than 
setuid bit.

Does it all make any sense?
thanks for responses

--
wixor
May the Source be with you
