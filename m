Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUJYKxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUJYKxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUJYKxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:53:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:15831 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261756AbUJYKxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:53:03 -0400
Date: Mon, 25 Oct 2004 12:52:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ych43 <ych43@student.canterbury.ac.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: process with socket
In-Reply-To: <417B54C1@webmail>
Message-ID: <Pine.LNX.4.53.0410251252180.18644@yvahk01.tjqt.qr>
References: <417B54C1@webmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
> I am working on UNIX Network Programming (sockets programming in C). My
>problem is I do not know how to identify whether a process in Linux kernel has
>a socket. Because so many different processes in Linux kernel are running, a
>process forks many child processes and forms a process tree. I want to
>identify a process that has socket and saves state data about it. Then saves
>the same data about his parent process and walks up the process tree by
>repeating this procedure until a process with PID 0 is reached. But I do not
>know how to identify if a process has a socket.

This might give you a start:

$ find /proc -type s

or

$ ls -Rl /proc/[0-9]* | grep ^s



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
