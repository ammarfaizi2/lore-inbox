Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTFQTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTFQTJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:09:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22417 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264890AbTFQTJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:09:26 -0400
Message-ID: <3EEF6A9D.6050303@pobox.com>
Date: Tue, 17 Jun 2003 15:23:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Janice M Girouard <janiceg@us.ibm.com>
CC: "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu, Janice Girouard <girouard@us.ibm.com>,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>	<20030617090859.0ffa0ca8.shemminger@osdl.org> <20030617.090930.102574393.davem@redhat.com> <3EEF620A.40608@pobox.com> <3EEF66AA.3000509@us.ibm.com>
In-Reply-To: <3EEF66AA.3000509@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janice M Girouard wrote:
> 2) events that drive load balancing software.  Right now if we need to 
> throttle the card, we don't send events up to indicate we have reached 
> capacity. 


Question related to this item specifically :)

Do you want to individually send 4000 - 16000 (or more) TX stop / start 
events per second to userspace?  :)  At some point Heisenburg defeats 
low latency :)

If not (and I hope not), perhaps also look into the net stack statistics 
already kept (or add more sampling stats if necessary), and instead 
trigger events based on sampling those statistics.

	Jeff



