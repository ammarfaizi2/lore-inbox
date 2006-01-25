Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWAYGic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWAYGic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWAYGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:38:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65195 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751043AbWAYGic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:38:32 -0500
Subject: Re: My Linux doesn't honor "kill -9"...Is it a bug or a feature?
From: Arjan van de Ven <arjan@infradead.org>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE944119C@IN01WEMBX1.internal.synopsys.com>
References: <7EC22963812B4F40AE780CF2F140AFE944119C@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 07:38:28 +0100
Message-Id: <1138171108.3001.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 11:59 +0530, Arijit Das wrote:
> My GNU/Linux system sometimes doesn't seem to honor the 'KILL' signal
> which is supposed to be a sure-shot killer.


-9 doesn't kill processes in "D" state.
"D" state is a state where they are in the kernel, usually waiting for
IO of some kind of for a semaphore.

The fact that they're stuck is a kernel bug somewhere; to diagnose we
(or probably your OS vendor given you're running a highly antique
kernel) the output of "echo t > /proc/sysrq-trigger", and especially the
part of the dump that shows the process in "D" state.



