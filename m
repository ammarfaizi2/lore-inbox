Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVJCSwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVJCSwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVJCSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:52:54 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:7903 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbVJCSwx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:52:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uj4nhW60WEavRrIvFQUN0ffqInuKc/wzJdFB05+fwNEaoYrIGgDqPec2BLL00GxZEs/rKUPaQmN20NJAFw6fQF+N996lsa8CgBsn110lIYxkNpAIGserEupviSwDyo12cRVUZMAmjjjIm7CfJoQCzTn0aQAY1f2v00JDEf+jmJU=
Message-ID: <105c793f0510031152v76225bc7r83e5e2170f3434d5@mail.gmail.com>
Date: Mon, 3 Oct 2005 14:52:52 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: A possible idea for Linux: Save running programs to disk
Cc: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051003174122.GD3652@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
	 <105c793f0510012236j16033efbh400f6f2a8495d03e@mail.gmail.com>
	 <20051003174122.GD3652@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Adrian Bunk <bunk@stusta.de> wrote:
> Where are hardware issues with suspend to disk?
>
Actually, very few currently [AFAIK, on my hardware]. However, at
least in the past, my r200 card wasn't useable after resume from
suspend without patches to XFree86. I know people had trouble with the
fglrx drivers not supporting suspend-to-disk. [I believe current r300
drivers work fine, but I do not have personal confirmation.] I have a
machine that used to have issues because I was using a keyboard and no
mouse. When I resumed, the keyboard didn't work. If I had a mouse
plugged in, suspend/resume worked fine. Here's a link to my mail to
LKML about this issue:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112139506118959&w=2

As new hardware is introduced and drivers have to be written or
reverse-engineered and kinks worked out, bugs like these will crop up
again and again. [That is, unless manufacturers become more open about
their hardware. From my perspective, they are becoming more closed.
ATI, for example.]

If processes could be suspended to disk independantly of the "physical
state" of the machine, it would avoid issues like these. You could
"suspend-to-disk", install a new video/sound/network card and then
resume as though nothing happened. (Ignoring issues with TCP, of
course.)

Neat.

-Andy
