Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUHTQdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUHTQdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUHTQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:33:31 -0400
Received: from holomorphy.com ([207.189.100.168]:27849 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266498AbUHTQdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:33:23 -0400
Date: Fri, 20 Aug 2004 09:33:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: setproctitle
Message-ID: <20040820163322.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040818082851.GA32519@DervishD> <20040818085850.GW11200@holomorphy.com> <20040820162027.GA1238@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820162027.GA1238@DervishD>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> dixit:
>> The command-line arguments are being fetched from the process address
>> space, i.e. simply editing argv[] in userspace will have the desired
>> effect. Though this code is butt ugly.

On Fri, Aug 20, 2004 at 06:20:27PM +0200, DervishD wrote:
>     The problem with this is that is non-portable. Not all Unices
> (AFAIK) have this behaviour. The portable solution for changing
> argv[0] is to use ONLY the space currently allocated to argv[0]. I
> mean, you take argv[0], do a strlen() and overwrite only strlen bytes
> of it. The problem with this is that you cannot write an arbitrary
> string there. If all Unices provide 'setproctitle' that problem
> dissapears.
>     Anyway is cool to know that, under Linux, I can change the
> argv[0] with no problems.

It is not portable behavior. It is a description of how to implement
setproctitle(3) in Linux.


-- wli
