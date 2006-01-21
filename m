Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWAUBTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWAUBTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWAUBTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:19:38 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:5164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbWAUBTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:19:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UbLW/XoMSG9LbIVlsBHySDgpGXiZPgBv4Dynlsbwa5ZLCl/aJujP7un+pYXtRpyJsMeJtLltEoapmvP0Dsy9WMwIzcC+lQLTgA/V8F221O1CyOgd0F1WHlDu3tKUuNuwu2cxiSNmasgD9GFUP+hd2pIWuhkKvcJRBnicMN01k8A=
Message-ID: <56a8daef0601201719t448a6177lfebabe3ca38a00c7@mail.gmail.com>
Date: Fri, 20 Jan 2006 17:19:33 -0800
From: John Ronciak <john.ronciak@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: My vote against eepro* removal
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, kus Kusche Klaus <kus@keba.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1137804050.3241.32.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
	 <20060120095548.GA16000@2ka.mipt.ru>
	 <1137804050.3241.32.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> Seems like the important question is, why does e100 need a watchdog if
> eepro100 works fine without one?  Isn't the point of a watchdog in this
> context to work around other bugs in the driver (or the hardware)?
There are a number of things that the watchdog in e100 does.  It
checks link (up, down), reads the hardware stats, adjusts the adaptive
IFS and checks to 3 known hang conditions based on certain types of
the hardware.  You might be able to get around without doing the
work-arounds (as long as you don't' see hangs happening with the
hardware being used) but the checking of the link and the stats are
probably needed.


--
Cheers,
John
