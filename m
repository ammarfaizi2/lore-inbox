Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVB0V4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVB0V4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVB0V4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:56:04 -0500
Received: from h34-aclarke.sv.meer.net ([205.217.153.34]:46058 "EHLO
	ofb3.ofb.net") by vger.kernel.org with ESMTP id S261330AbVB0Vzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:55:48 -0500
Date: Sun, 27 Feb 2005 13:55:19 -0800
From: Frederik Eaton <frederik@a5.repetae.net>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: postmaster@vger.kernel.org
Subject: Re: Majordomo results
Message-ID: <20050227215519.GA21657@a5.repetae.net>
Reply-To: frederik@ofb.net
References: <S261762AbVBZFAO/20050226050014Z+35@vger.kernel.org> <20050226052158.GA19286@a5.repetae.net> <20050226134946.690df06a.davem@davemloft.net> <20050227041745.GA4323@a5.repetae.net> <20050226204058.5c19ea26.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226204058.5c19ea26.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 08:40:58PM -0800, David S. Miller wrote:
> On Sat, 26 Feb 2005 20:17:45 -0800
> Frederik Eaton <frederik@a5.repetae.net> wrote:
> 
> > Wait... how is the address to which I'm trying to subscribe defined if
> > the email field has to be empty?
> 
> If it's empty Majordomo uses the From: of the email the request
> comes from, that's the most error-proof way to add yourself.

No, actually it appears to use Reply-To: in preference to From: if it
exists, apparently that was my (its) problem. Can you change this
error message:

> >>>> auth 51a49557 subscribe linux-kernel frederik@a5.repetae.net
> Your request to Majordomo@vger.kernel.org:
> 
>         subscribe linux-kernel frederik@a5.repetae.net
> 
> has been forwarded to the owner of the "linux-kernel" list for approval.
> This could be for any of several reasons:
> 
>     You might have asked to subscribe to a "closed" list, where all new
>         additions must be approved by the list owner.
> 
>     You might have asked to subscribe or unsubscribe an address other than
>         the one that appears in the headers of your mail message.
> 
> When the list owner approves your request, you will be notified.
> 
> If you have any questions about the policy of the list owner, please
> contact "linux-kernel-approval@vger.kernel.org".
> 
> 
> Thanks!

to say something like this:

> >>>> auth 51a49557 subscribe linux-kernel frederik@a5.repetae.net
> Your request to Majordomo@vger.kernel.org:
> 
>         subscribe linux-kernel frederik@a5.repetae.net
> 
> has been forwarded to the owner of the "linux-kernel" list for
> approval. This is most likely because you have asked to subscribe or
> unsubscribe an address other than the one that appears in the
> Reply-To: header of your mail message, if it exists, or the From:
> header otherwise. We do this not to prevent people from abusively
> subscribing others, but to make it hard for people to subscribe who
> wouldn't be able to figure out how to unsubscribe later, which cause
> us a great deal of trouble.
> 
> If the list owner approves your request (although really, you
> shouldn't hold your breath) you will be notified.
> 
> If you have any questions about the policy of the list owner, please
> contact "linux-kernel-approval@vger.kernel.org".
> 
> 
> Thanks!

Your assertion that only From: was used caused me to reverify a couple
of times that none of my outgoing MTAs were rewriting my From:
headers, before I tried subscribing without Reply-To:. I think putting
in the error message a description of exactly what the behavior of
your list server is, along with removing the suggestion of the
possibility that the list might be closed (are any vger lists
closed?), and that the user should wait for the owner to take action,
would be of great help to users who are trying to subscribe and are
indeed *not* clueless. Actually, I'm not an expert in mailing list
logic, but I also don't see any reason not to let the subscription
address match either From: *or* Reply-To: *or*, say, Sender:, rather
than taking the first header it finds as it seems to do now.

Thanks,

Frederik Eaton

