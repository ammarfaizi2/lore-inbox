Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWBHH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWBHH1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWBHH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:27:09 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:38093 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161060AbWBHH1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:27:08 -0500
Date: Tue, 7 Feb 2006 23:27:01 -0800 (PST)
From: John Schmerge <schmerge@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Question regarding /proc/<pid>/fd and pipes
Message-ID: <Pine.LNX.4.58.0602072302480.29064@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I'm attempting to track down a spooky problem with some code that I've
written (running under the 2.6.11.12 kernel) and am wondering if there's a
way to track (via /proc) both ends of an open pipe that was created with a
pipe(2) system call... It appears that I've got a bunch of spawned
processes stuck in some kind of sleep caused by a read(2) on the
read-end of a pipe and would like to eliminate the possibility that I've
done something truly bone-headed in my code like leaving the write-end
of the pipe open in another process. (I don't think I did, but want to
be sure :).

  I know that the symlinks in the /proc/<pid>/fd directory point to
bogus filenames for pipes (i.e. 'pipe:[64682]') and am wondering if
every process that reads and writes from that pipe will share the same
bogus symlink name.

  In essence, I'm wondering if there's any way to list all of the pid's
of processes using an anonomous pipe.

  Please CC me on any answers.

  Thanks,
  John
