Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbRF1Vt0>; Thu, 28 Jun 2001 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264561AbRF1VtS>; Thu, 28 Jun 2001 17:49:18 -0400
Received: from u-234-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.234]:60404
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S264506AbRF1VtK>; Thu, 28 Jun 2001 17:49:10 -0400
Date: Thu, 28 Jun 2001 23:46:59 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Ryan W. Maple" <ryan@guardiandigital.com>
Cc: Justin Guyett <justin@soze.net>, james bond <difda@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: BIG PROBLEM
Message-ID: <20010628234659.A8105@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.33.0106281413080.23200-100000@gw.soze.net> <Pine.LNX.4.10.10106281734140.11669-100000@mastermind.inside.guardiandigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106281734140.11669-100000@mastermind.inside.guardiandigital.com>; from ryan@guardiandigital.com on Thu, Jun 28, 2001 at 05:35:14PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 05:35:14PM -0400, Ryan W. Maple wrote:

> Check out:  http://bugs.debian.org/85478
> 
>   "When klogd's LogLine() function encounters a null byte in state
>    PARSING_TEXT, it will loop infinitely.  More precisely, copyin()
>    will treat the null byte as a delimiter - unlike LogLine(), which
>    will invoke copyin() ever and ever again."
> 
> Kinda off-topic, but I just wanted to prove that the bug was in klogd and
> not the kernel. :)

The kernel definately shouldn't communicate with the user using NUL chars.

  Ralf
