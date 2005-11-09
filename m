Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVKIBAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVKIBAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKIBAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:00:15 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:36367 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S932403AbVKIBAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:00:13 -0500
To: linas <linas@austin.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
References: <20051107185621.GD19593@austin.ibm.com>
	<20051107190245.GA19707@kroah.com>
	<20051107193600.GE19593@austin.ibm.com>
	<20051107200257.GA22524@kroah.com>
	<20051107204136.GG19593@austin.ibm.com>
	<1131412273.14381.142.camel@localhost.localdomain>
	<20051108232327.GA19593@austin.ibm.com>
	<B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	<20051109003048.GK19593@austin.ibm.com>
	<m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
	<20051109004808.GM19593@austin.ibm.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Tue, 08 Nov 2005 19:59:56 -0500
In-Reply-To: <20051109004808.GM19593@austin.ibm.com> (linas@austin.ibm.com's message of "Tue, 8 Nov 2005 18:48:08 -0600")
Message-ID: <m21x1qhbzn.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas <linas@austin.ibm.com> writes:

> On Tue, Nov 08, 2005 at 07:37:20PM -0500, Douglas McNaught was heard to remark:
>> 
>> Yeah, but if you're trying to read that code, you have to go look up
>> the declaration to figure out whether it might affect 'foo' or not.
>> And if you get it wrong, you get silent data corruption.
>
> No, that is not what "pass by reference" means. You are thinking of
> "const", maybe, or "pass by value"; this is neither.  The arg is not 
> declared const, the subroutine can (and usually will) modify the contents 
> of the structure, and so the caller will be holding a modified structure
> when the callee returns (just like it would if a pointer was passed).

Right.  My point is only that it's not clear from looking at the call
site whether a struct passed by reference will be modified by the
callee (some people pass by reference just for "efficiency").  And if
the called function modifies the data without the caller's knowledge,
it leads to obscure bugs.  Whereas if you pass a pointer, it's
immediately clear that the called function can modify the pointed-to
object.

-Doug
