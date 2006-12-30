Return-Path: <linux-kernel-owner+w=401wt.eu-S1030275AbWL3FVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWL3FVt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 00:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWL3FVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 00:21:49 -0500
Received: from web88205.mail.re2.yahoo.com ([206.190.37.220]:46414 "HELO
	web88205.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030275AbWL3FVt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 00:21:49 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 00:21:48 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DT01znZdg0esE0RJz65D34E9DgMY/R0VU2wZ97wKKDE4P6EJlIotFeYUAtSZcnC9YL9E/eHA2Wf5EPRh3Vpd5Amge2WTN3giiRKommzKNXJmhuyL5Bldy7Uy5/2OcXPm+PnVZoUhsji+izkUO+S4pcCr08Vy4QpNGthaJCEGp20=  ;
Message-ID: <20061230051507.16292.qmail@web88205.mail.re2.yahoo.com>
Date: Fri, 29 Dec 2006 21:15:07 -0800 (PST)
From: DAVID HORNER <dhorner@rogers.com>
Subject: [KORG] re: [PATCH] cfq-iosched: tighten allow merge criteria - error in final return value ?
To: linux-kernel@vger.kernel.org
Cc: jens.axboe@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I noticed a probable error in commit 719d34027e1a186e46a3952e8a24bf91ecc33837

> ....
> - if (cfqq != RQ_CFQQ(rq))
> - return 0;
> + 
> + if (cfqq == RQ_CFQQ(rq))
> + return 1;
>
>  return 1;
>  }

  Either the final return value should be 0 (zero) or
   the if statement is redundant.
 
   (I lack the skill to make a timely patch,hope this helps)


