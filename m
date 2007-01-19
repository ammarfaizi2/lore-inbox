Return-Path: <linux-kernel-owner+w=401wt.eu-S964934AbXASOxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXASOxS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXASOxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:53:18 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:4941 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964934AbXASOxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:53:17 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Fri, 19 Jan 2007 14:53:12 +0000
User-Agent: KMail/1.9.5
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <20070115234650.GA2124@atjola.homenet> <45AC1DA3.5040104@shaw.ca>
In-Reply-To: <45AC1DA3.5040104@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191453.12482.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 00:34, Robert Hancock wrote:
> I'll try your stress test when I get a chance, but I doubt I'll run into
> the same problem and I haven't seen any similar reports. Perhaps it's
> some kind of wierd timing issue or incompatibility between the
> controller and that drive when running in ADMA mode? I seem to remember
> various reports of issues with certain Maxtor drives and some nForce
> SATA controllers under Windows at least..

I have exactly the same problem on -rc5 and it causes all I/O to stall 
periodically if I do _anything_ I/O intensive.

On my box, I have 4 sata_nv handled SATA ports, with two pairs of different 
drives (two Maxtor, two WD) and it happens randomly on both. So it's 
absolutely nothing to do with the drive make/model.

I'll try Jeff's suggestion of disabling ADMA now, but I think something more 
radical than this workaround should make it into 2.6.20 final, otherwise a 
lot of people are going to have broken boxes.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
