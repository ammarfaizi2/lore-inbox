Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbVKIAsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVKIAsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKIAsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:48:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:56531 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932391AbVKIAsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:48:16 -0500
Date: Tue, 8 Nov 2005 18:48:08 -0600
To: Douglas McNaught <doug@mcnaught.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109004808.GM19593@austin.ibm.com>
References: <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 07:37:20PM -0500, Douglas McNaught was heard to remark:
> 
> Yeah, but if you're trying to read that code, you have to go look up
> the declaration to figure out whether it might affect 'foo' or not.
> And if you get it wrong, you get silent data corruption.

No, that is not what "pass by reference" means. You are thinking of
"const", maybe, or "pass by value"; this is neither.  The arg is not 
declared const, the subroutine can (and usually will) modify the contents 
of the structure, and so the caller will be holding a modified structure
when the callee returns (just like it would if a pointer was passed).

--linas


