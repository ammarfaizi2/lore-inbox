Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTHYImr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTHYImr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:42:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261738AbTHYImp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:42:45 -0400
Date: Mon, 25 Aug 2003 09:42:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Personnal line discipline difficulties
Message-ID: <20030825094242.B28712@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>,
	linux-kernel@vger.kernel.org
References: <200308251018.58127.laurent.huge@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308251018.58127.laurent.huge@wanadoo.fr>; from laurent.huge@wanadoo.fr on Mon, Aug 25, 2003 at 10:18:58AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 10:18:58AM +0200, Laurent Hugé wrote:
> the result is not constant : sometimes, the line discipline receive the 11 
> caracters (including the 0D and 0A termination), but most of the time, it 
> receive firstly 8 the 3 caracters. The *fp value is always 0 (so there's no 
> error !).

That's not correct.  fp is an array of error characters, length "count".
Each entry corresponds directly with each received character.

I take it you know that receive_buf can be called at any time with any
number of characters?  In other words, it doesn't have any framing on
the group of characters it may hand you.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

