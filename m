Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJJNfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJJNfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:35:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:10647 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262799AbTJJNfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:35:18 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Subject: Re: 2.7 thoughts
Date: Fri, 10 Oct 2003 08:30:03 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org>
In-Reply-To: <3F864F82.4050509@longlandclan.hopto.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310100830.03216.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 October 2003 01:19, Stuart Longland wrote:
> 	- Software RAID 0+1 perhaps?
>
> 		A lot of hardware RAID cards support it, why not the
> 		kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
>		stripe-RAID arrays.  (Or can this be done already?)

This can be done already. For example, you have six drives, sd[a-f]. Create 
md0 (raid-0) using sda, sdb, and sdc. Create md1 (raid-0) using sdd, sde, and 
sdf. Then create md2 (raid-1) using md0 and md1. This setup can easily be 
accomplished using evms, mdadm, or raidtools.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

