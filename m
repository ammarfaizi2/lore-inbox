Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWHNL1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWHNL1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWHNL1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:27:09 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:21991 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751993AbWHNL1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:27:08 -0400
Date: Mon, 14 Aug 2006 13:26:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Anton Blanchard <anton@samba.org>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Message-ID: <20060814112656.GC10164@wohnheim.fh-wedel.de>
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060811205624.GE479@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 August 2006 06:56:24 +1000, Anton Blanchard wrote:
> 
> > +
> > +				skb_index = ((index - i
> > +					      + port_res->skb_arr_sq_len)
> > +					     % port_res->skb_arr_sq_len);
> 
> This is going to force an expensive divide. Its much better to change
> this to the simpler and quicker:
> 
> i++;
> if (i > max)
> 	i = 0;

Is a conditional cheaper than a divide?  In case of a misprediction I
would assume it to be significantly slower and I don't know the ratio
of mispredictions for this branch.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
