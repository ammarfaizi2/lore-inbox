Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756344AbWK0DT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbWK0DT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbWK0DT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:19:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:46426 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756325AbWK0DTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:19:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=O6ZIJhnmdWFvfIB90crFkT0GAWUqZeP2LmG7obShWcagz3vXwJePoXJCw01NykuyN+7bI4k2xEDq8zdMEuwKVSuym2buahNinoCnaefyaacVIxDCa/TRbrJf8/b5Kjdv8fjJfOcNRZerfCSgL9QaskCZ+0o3HgCWydE6IU+lGo8=
Message-ID: <456A5936.9080903@gmail.com>
Date: Mon, 27 Nov 2006 12:19:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "gary.czek" <gary@czek.info>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH6M SATA Controller, SATA2 NCQ disk and high iowait CPU time
References: <1164404380.20334.37.camel@localhost>
In-Reply-To: <1164404380.20334.37.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gary.czek wrote:
> Hi, I have problem with my notebook Fujitsu-Siemens V8010. It has Intel
> ICH6M chipset with SATA Controller. And SATA II disk Fujitsu MHT2040BH
> with NCQ. If there is request on disk, iowait time of CPU gets to 100%
> and whole system gets totally unresponsible. For example apt upgrade (of
> average 10 packages totaling 30MB in .debs) gets 30 minutes. CPU iowait
> time gets about 95% for whole 30 minutes.
> 
> My notebook details:
> CPU: Intel Celeron M 1,4GHz
> MEM: 256MB 333MHz
> HDD: Fujitsu MHT2040BH SATA II, NCQ, 5400rpm, 8MB buffer
> SWP: 512MB swap partition
> Chipset: ICH6M 82801FBM
> GPU: Intel i915GM integrated
> 
> kernel: 2.6.19-rc5
> SATA Controller/disk driver: ata_piix and ahci tested, but results of
> both were almost the same.

1. does 'mount -o remount,barrier=0 /' change anything?

2. 256MB is really small if you're running modern desktop environment. 
Please post the result of 'vmstat 5' while the machine is really slow.

-- 
tejun
