Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWDVRwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDVRwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWDVRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:52:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750824AbWDVRwC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:52:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O6HISF1VjB8Wj/dQsjgdBP5R0Pem1RkCoDMqyRWsLzGBY19gXrm0LjIDsQLGH9xOpYfQXtJMDxxsWY5Er7+ri3ke/fGAJvPyS6P9bH9pt+b6GtnCUxiOXcz98+qg+niH23N1vlfeOEu9AZ7lPXc2rBap5ltiJPzWEWkU0hmxTMM=
Message-ID: <84144f020604220043i65502955ha6dc2759d8cd665b@mail.gmail.com>
Date: Sat, 22 Apr 2006 10:43:22 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: kfree(NULL)
Cc: "Andrew Morton" <akpm@osdl.org>, "James Morris" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0604210322110.21429@d.namei>
	 <20060421015412.49a554fa.akpm@osdl.org>
	 <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> > Yes, kfree(NULL) is supposed to be uncommon.  If someone's doing it a lot
> > then we should fix up the callers.

On 4/22/06, Paul Mackerras <paulus@samba.org> wrote:
> Well, we'd have to start by fixing up the janitors that run around
> taking out the if statements in the callers.  :)

No, it's not the janitors fault that we have paths doing lots of
kfree(NULL) calls. NULL check removal didn't create the problem, but
it makes it more visible definitely.

                                                Pekka
