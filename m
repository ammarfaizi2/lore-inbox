Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCaS4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCaS4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVCaS4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:56:49 -0500
Received: from fmr18.intel.com ([134.134.136.17]:55936 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261616AbVCaS4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:56:32 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in a tasklet.
Date: Thu, 31 Mar 2005 10:48:25 -0800
User-Agent: KMail/1.5.4
References: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311048.25674.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 07:20, Bouchard, Sebastien wrote:
> Hi,
>
> I'm in the process of writing a linux driver and I have a question in
> regards to tasklet :
>
> Is it ok to have large delay "udelay(1000);" in the tasklet?
>
> If not, what should I do?
>

If the hardware can tolerate longer a longer or variable delays, then perhaps 
putting the work that has the large delay on a one shot timer would work?

If that doesn't cut it, then I wonder if you could structure your taskelt 
processing around a kernel thread.

Is this for 2.6 or 2.4 based kernels?

--mgross

