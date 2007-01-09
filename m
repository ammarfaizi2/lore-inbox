Return-Path: <linux-kernel-owner+w=401wt.eu-S932255AbXAIRI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXAIRI4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbXAIRIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:08:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56258 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbXAIRIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:08:55 -0500
Message-ID: <45A3CC15.1030005@zytor.com>
Date: Tue, 09 Jan 2007 09:08:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   just to stir the pot a bit regarding the discussion of the two
> different ways to define macros, i've just noticed that the "({ })"
> notation is not universally acceptable.  i've seen examples where
> using that notation causes gcc to produce:
> 
>   error: braced-group within expression allowed only inside a function
> 
> i wasn't aware that there were limits on this notation.  can someone
> clarify this?  under what circumstances *can't* you use that notation?
> thanks.
> 

Well, you can apparently not use it as a part of a constant expression 
(which makes sense; do-while is illegal there too.)  That would be the 
only case in which an expression is permitted outside a function at all.

	-hpa

