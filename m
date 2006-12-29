Return-Path: <linux-kernel-owner+w=401wt.eu-S965143AbWL2U0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWL2U0u (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWL2U0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:26:50 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:22993 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965143AbWL2U0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:26:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=HMuKD3LIAzPV3NNpy1IkRwIC2cFIS7NeOiyfR3qxWEVuAYnOw5W58hHv2WfFX9GgGzDnY+On9yydALCw+mS0+BaPzgdlAqVAjnSDHRRhnb+/1GwfICmkkUdQGGteog+sqMpdQ6MTpvINlPi3hxWK9vuCQKY8kPc8SU/wgXb2Vn0=  ;
X-YMail-OSG: RUVOWdQVM1nRYBo5gBExhtvEKSGxIHouINTQ.YVbLJ7g4z73eP4DEXdgHbdrN2IA5sHb62GI54aMqXrIENnnQn5d.hvIieYAV6VLMKF26q6o.nHiq.Ul853IBr5WNAcHZIkPocU0s1._u_o-
From: David Brownell <david-b@pacbell.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Date: Fri, 29 Dec 2006 12:26:46 -0800
User-Agent: KMail/1.7.1
Cc: Imre Deak <imre.deak@solidboot.com>, linux-kernel@vger.kernel.org,
       nicolas.ferre@rfo.atmel.com, tony@atomide.com
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200612281437.56888.david-b@pacbell.net> <200612290122.52752.dtor@insightbb.com>
In-Reply-To: <200612290122.52752.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612291226.46984.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 10:22 pm, Dmitry Torokhov wrote:
> 
> I appied all patches except for hwmon as it had some issues with CONFIG_HWMON
> handling. Could you please take a look at the patch below and tell me if it
> works for you?

Looked OK, except:

> +#if defined(CONFIG_HWMON) || (defined(MODULE) && defined(CONFIG_HWMON_MODULE))

That idiom is more usually written

	#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)

Thanks!  I'll be glad to see fewer versions of this driver floating around.
And to see the next version of the ads7843 patches ... :) 

- Dave

