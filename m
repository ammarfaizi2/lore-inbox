Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJCUli>; Thu, 3 Oct 2002 16:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSJCUli>; Thu, 3 Oct 2002 16:41:38 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:43767 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261397AbSJCUlJ>; Thu, 3 Oct 2002 16:41:09 -0400
Date: Thu, 3 Oct 2002 16:46:41 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: george anzinger <george@mvista.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual PPro timer stopping problem
Message-ID: <20021003164641.F16875@redhat.com>
References: <14632.1033653828@warthog.cambridge.redhat.com> <3D9C7E7E.7B2BFB52@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9C7E7E.7B2BFB52@mvista.com>; from george@mvista.com on Thu, Oct 03, 2002 at 10:29:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:29:34AM -0700, george anzinger wrote:
> The keyboard is, or at least depends on polling which is
> controled by a timer, thus, no timer, => no keyboard.

Eh?  Sure, by a timer internal to the keyboard itself.  At least x86 
hardware has an interrupt wired to its keyboard controller that is used 
to signal when a keystroke is available, and if you look into the driver, 
you'd see that no timers are used at all.

		-ben
