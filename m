Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVI3DgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVI3DgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVI3DgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 23:36:12 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:39233 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751069AbVI3DgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 23:36:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HFmQDqDbRxR5J62JutZ//dYDqcIZITT8KgKfmbBkMCvZxyg+vz6AdJ8uE3Y5LoZew+59GzG0jcSH4NhLhcrsGyxfbApv90+RffUnawIYSbGWqxmoWSo0NhBssuoN1Ku1+WyqsrTbN12UDOtTu0kWa9irp9W4jIvtdxcrqmIScT8=
Message-ID: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
Date: Fri, 30 Sep 2005 05:36:08 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

 Traced a panicing kernel to what appears the starfire changes for
2.6.13 up to 2.6.14_rc2

During a relative heavy NFS read (client a 32bit 2.6.13.1 P2-350) with
rsync (ripped CD archive) I get kernel panics (Aieee interupt handler
lost or something... okay also need
a way to capture those errors as it's a hard panic and needs a reset button :()

I've isolated the problem going from 2.6.12.5/2.6.12-gentoo-r10 (both
working) to
2.6.13/2.6.13-gentoo/2.6.14_rc2 while the NFS is served through the
Adaptec/starfire,
and further more the onboard forceth(nvidia) is serving the data
without hassles (at least
on 2.6.14_rc2)

Using gcc 3.4.4

--
Hendrik Visage
