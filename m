Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030699AbVKITif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030699AbVKITif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbVKITif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:38:35 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3050 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030699AbVKITie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:38:34 -0500
Date: Wed, 9 Nov 2005 13:38:28 -0600
To: thockin@hockin.org
Cc: Vadim Lobanov <vlobanov@speakeasy.net>,
       "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109193828.GR19593@austin.ibm.com>
References: <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <20051109193625.GA31889@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109193625.GA31889@hockin.org>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 11:36:25AM -0800, thockin@hockin.org was heard to remark:
> On Wed, Nov 09, 2005 at 01:20:28PM -0600, linas wrote:
> > I guess the real point that I'd wanted to make, and seems
> > to have gotten lost, was that by avoiding using pointers, 
> > you end up designing code in a very different way, and you
> > can find out that often/usually, you don't need structs
> > filled with a zoo of pointers.
> 
> Umm, references are implemented as pointers.  Instead of a "zoo of
> pointers" you have a "zoo of references".  No functional difference.

Sigh.

I think you are confusing references and pointers. By definition
you cannot "store a reference"; however, you can "dereference"
an object and store a pointer to it.

The C programming language conflates these two different ideas;
that is why they seem to be "the same thing" to you.

> > Minimizing pointers is good: less ref counting is needed,
> > fewer mallocs are needed, fewer locks are needed 
> > (because of local/private scope!!), and null pointer 
> > deref errors are less likely. 
> 
> Not true at all!  

Which part isn't true? 

--linas
