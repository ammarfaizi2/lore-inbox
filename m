Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWFSOVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWFSOVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWFSOVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:21:19 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:59614 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S932450AbWFSOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:21:19 -0400
Message-ID: <4496B2D0.3070405@free-electrons.com>
Date: Mon, 19 Jun 2006 16:21:04 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ~ ninad <ninad.gfx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq
References: <1150723865.976316.296170@f6g2000cwb.googlegroups.com>
In-Reply-To: <1150723865.976316.296170@f6g2000cwb.googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> In linux device driver, is it possible to register an ISR for multiple
> irq lines?
>   
Yes, use request_irq with the same handler for each of your irq lines.

You couldn't easily do this at once in a single request_xxx instruction, 
because registration may succeed on some lines, but fail on some others 
ones. The registration status would then be more difficult to manage.

   Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

