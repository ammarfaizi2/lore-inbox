Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265455AbRFVQAM>; Fri, 22 Jun 2001 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265454AbRFVQAD>; Fri, 22 Jun 2001 12:00:03 -0400
Received: from ns.suse.de ([213.95.15.193]:43015 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265453AbRFVP7w>;
	Fri, 22 Jun 2001 11:59:52 -0400
Date: Fri, 22 Jun 2001 17:59:44 +0200
From: Andi Kleen <ak@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: About I/O callbacks ...
Message-ID: <20010622175944.A6968@gruyere.muc.suse.de>
In-Reply-To: <ouplmml6jjf.fsf@pigdrop.muc.suse.de> <XFMail.20010622085500.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010622085500.davidel@xmailserver.org>; from davidel@xmailserver.org on Fri, Jun 22, 2001 at 08:55:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 08:55:00AM -0700, Davide Libenzi wrote:
> I know about rt signals and SIGIO :) but I can't see how You can queue signals :
> 
> current->sig->action[..]
> 
> The action field is an array so if more than one I/O notification is fired
> before the SIGIO is delivered, You'll deliver only the last one.
> Am I missing something ?

Yes. Realtime signals (>=SIGRTMIN) get queued in current->pending.

-Andi
