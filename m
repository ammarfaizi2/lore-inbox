Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWDGPxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWDGPxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWDGPxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:53:31 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:54968 "EHLO
	suzuka.mcnaught.org") by vger.kernel.org with ESMTP id S964810AbWDGPxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:53:30 -0400
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: How to know when file data has been flushed into disk?
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Fri, 07 Apr 2006 11:53:29 -0400
In-Reply-To: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com> (Xin
 Zhao's message of "Fri, 7 Apr 2006 11:42:09 -0400")
Message-ID: <87slop1ix2.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Xin Zhao" <uszhaoxin@gmail.com> writes:

> 3. Does sys_close() have to  be blocked until all data and metadata
> are committed? If not, sys_close() may give application an illusion
> that the file is successfully written, which can cause the application
> to take subsequent operation. However, data flush could be failed. In
> this case, file system seems to mislead the application. Is this true?
> If so, any solutions?

The fsync() call is the way to make sure written data has hit the
disk.  close() doesn't guarantee that.

-Doug
