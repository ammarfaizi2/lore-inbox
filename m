Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWAVUSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWAVUSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAVUSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:18:47 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:2284 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751338AbWAVUSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:18:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=At6HX98EbyAbgW5WNp8XX78hQRA7B9gQ2mknLXqFWe9H2Odvyk7g60S2VTsWX+dT7/U/Oy4c4s7QSHx2ljMQqGOxxsfZP+Xqs5bVRQvioP27BfjlbGibwm/iNavCwTaYQxjtyWFA67HrI7I7juf41ZNcJymhqVOm/NvvCvAe3HY=
Date: Sun, 22 Jan 2006 20:16:06 +0100
From: Diego Calleja <diegocg@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_ACPI_PROCESSOR=y confuses the cpu scheduler
Message-Id: <20060122201606.5d335156.diegocg@gmail.com>
In-Reply-To: <20060119012040.733335f4.diegocg@gmail.com>
References: <20060119012040.733335f4.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 19 Jan 2006 01:20:40 +0100,
Diego Calleja <diegocg@gmail.com> escribió:

> If I compile CONFIG_ACPI_PROCESSOR in the kernel, one of the two cpus
> doesn't get scheduled any process. The CPU works and everything, it
> services interrupts and I can force processes to run on that CPU
> with taskset, but they won't get scheduled in that CPU no matter
> how much processes and load you put on the machine.


This has been reported by another person who found the culprit
commit: http://bugzilla.kernel.org/show_bug.cgi?id=5930
