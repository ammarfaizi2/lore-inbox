Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbUKXQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbUKXQCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXQAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:00:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63904 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262768AbUKXPoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:44:03 -0500
Date: Wed, 24 Nov 2004 15:44:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
Message-ID: <20041124144429.GA18515@elte.hu>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294252.5805.228.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294252.5805.228.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> New exports for suspend. I've cut them down some as a result of the
> last review, but could perhaps do more? Would people prefer to see a
> single struct wrapping exported functions?

> --- 400-exports-old/kernel/sched.c	2004-11-06 09:23:53.364977120 +1100
> +++ 400-exports-new/kernel/sched.c	2004-11-06 09:23:56.627481144 +1100
> @@ -3798,6 +3798,7 @@
>  
>  	read_unlock(&tasklist_lock);
>  }
> +EXPORT_SYMBOL(show_state);

this one is ok i think, but make it EXPORT_SYMBOL_GPL() please.

	Ingo
