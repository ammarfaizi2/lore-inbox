Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292295AbSCEVwD>; Tue, 5 Mar 2002 16:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSCEVvy>; Tue, 5 Mar 2002 16:51:54 -0500
Received: from www.fibrespeed.net ([216.168.105.33]:47604 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S292295AbSCEVvh>; Tue, 5 Mar 2002 16:51:37 -0500
Date: Tue, 5 Mar 2002 16:51:33 -0500
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
To: linux-kernel@vger.kernel.org
Subject: Changing subsystem priorities
Message-ID: <20020305215132.GG15698@godzilla.fibrespeed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the performance of one of my systems the other day and 
realised that it was often slowed by processes requesting disk I/O 
while other (often unrelated) processes were waiting to send network 
packets.  For the sake of thinking out loud, would it be possible to 
allow priority changes on a subsystem basis within the kernel?  That is 
to say, either tell the kernel that handling disk io is less important 
than handling network io (or vice versa) or perhaps that processes 
waiting for disk io be given their timeslices a little 'later' so that 
other non-disk-bound processes get a few more?  I understand that this 
is entirely based on the priorities I have for one sserver but other 
people may wish to accomplish similar things with different priorities. 
 Is this type of scheduler adjustment possible or even desirable?

For what its worth, the system in question is running 2.2.20 until I
find stable drivers for my DPT SmartRaid V controller for 2.4.x.
-- 
Michael T. Babcock
CTO, FibreSpeed Ltd.     (Hosting, Security, Consultation, Database, etc)
http://www.fibrespeed.net/~mbabcock/
