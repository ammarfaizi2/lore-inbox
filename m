Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbSKURGX>; Thu, 21 Nov 2002 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSKURGX>; Thu, 21 Nov 2002 12:06:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36362 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266903AbSKURGW>;
	Thu, 21 Nov 2002 12:06:22 -0500
Message-ID: <3DDD141F.4010402@pobox.com>
Date: Thu, 21 Nov 2002 12:13:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Robert Olsson <Robert.Olsson@data.slu.se>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
References: <15835.56316.564937.169193@robur.slu.se> <20021120164319.A26918@vger.timpanogas.org> <15836.47295.808423.41648@robur.slu.se> <20021121111010.A31363@vger.timpanogas.org>
In-Reply-To: <15835.56316.564937.169193@robur.slu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

>
> One other comment.  Does NAPI handle the issue of refilling the RX ring
> from interrupt?  This is the source of the problem, not packet 
> delvery, which
> is handled from a softirq handler.



NAPI poll does not happen in an interrupt.  Doing things in interrupts 
is the source of problems that NAPI is trying to solve.

Other than that, please read the code and NAPI paper...  :)

