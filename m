Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUCESNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUCESNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:13:22 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:49042 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S262671AbUCESNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:13:13 -0500
Date: Fri, 5 Mar 2004 10:13:22 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: server migration 
Message-ID: <20040305181322.GA32114@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.4-rc1-mm1 on an i686
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all! 

I tried about four months ago to migrate a busy server to 2.6.0-test9,
and failed miserably. Lightly loaded it worked well but as the number
of users increased, the number of processes in uninterruptible sleep
increased to the hundreds and then the server fell on it's face. I never
found out exactly why or what processes where hanging if I guessed it
would be openldap.

I'd like to take another shot at it with 2.6.3, I'd also like to get
some hints on how better to debug the problem; remember it is a live
server with live users, I can't spend much time before rebooting back to
a 2.4 kernel and yes 2.4.25 runs fine.

Things that are non-standard

Lots of open files, it's not unusual to have 50000 open files.
ext3 is mounted noatime,data=writeback on /home and /var 
Total processes are usually around 300 to 350.

Main applications are:

imap, exim and openldap running on Debian.


Questions, comments, flames are welcome.



-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


