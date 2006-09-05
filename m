Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWIESur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWIESur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWIESuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:50:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37918 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030215AbWIESuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:50:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucAIq7pjnk1ciqV5z9fMoT7V4xlswV2JMGOmnU5pNvsd0Si4mg237FJwrfltbKgPWrkgt0uexx3mcfWEbQvSDSOLulowG98+KIzb2LuzlvttcNrinMTSpZ2SU5bJwHGikqjRk+XJsQUuGBhRP7co5Rl1gpRmbAzQkX05MH50wxA=
Message-ID: <bbe04eb10609051150g2636c438gf88195499b85279c@mail.gmail.com>
Date: Tue, 5 Sep 2006 14:50:42 -0400
From: "Kimball Murray" <kimball.murray@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de
In-Reply-To: <1157479017.3186.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
	 <1157479017.3186.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

The "hooks" have default funtions in the patch (see track.c), all of
which do exactly what Stratus needs them to do.  Knowing that this
functionality is only needed by Stratus, the hook was my attempt to
allow other users of this interface to make it behave differently.  I
wouldn't object to removing the hooks and instead calling the default
functions directly.

-kimball

On 9/5/06, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Tue, 2006-09-05 at 13:34 -0400, Kimball Murray wrote:
> > +static __inline__ void mm_track_pte(void * val)
> > +{
> > +       if (unlikely(mm_tracking_struct.active))
> > +               do_mm_track_pte(val);
> > +}
>
> This patch just appears to be a big collection of hooks.  Could you post
> an example user of these hooks?  It is obviously GPL from all of the
> EXPORT_SYMBOL_GPL()s anyway, right?
>
> -- Dave
>
>
