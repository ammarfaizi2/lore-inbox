Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVAKCEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVAKCEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVAKCCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:02:21 -0500
Received: from main.gmane.org ([80.91.229.2]:53942 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262659AbVAKCBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:01:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: JustFillBug <mozbugbox@yahoo.com.au>
Subject: Re: Wrong value in the cp936 (gb2312) codepage.
Date: Tue, 11 Jan 2005 02:00:50 +0000 (UTC)
Message-ID: <slrncu6d1i.5uj.mozbugbox@mozbugbox.somehost.org>
References: <1105150357.1833.4.camel@mattwu>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm218-253-45-243.hkcable.com.hk
X-Mail-Copies-To: nobody
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-08, matt <coody@netease.com> wrote:
> Hi all,
>
> I accidentally got a wrong value in the cp936 (gb2312) codepage.
>
> in /linux/fs/nls/nls_cp936.c:
>
> static wchar_t c2u_B1[256] = {
> ...
> 0x5351,0xF963,0x8F88,0x80CC,0x8D1D,0x94A1,0x500D,0x72C8,/* 0xB0-0xB7 */
> ...
> };
>
> For 0xb1, 0xb1, the correct value should be 0x5317. You can get it at
> www.microsoft.com/globaldev/reference/dbcs/936/936_B1.htm.
>
> I didn't check all of them. But it should have possibility of containing
> more wrong values. Maybe these tables need to be re-generated.
>

Please see:
    http://bugzilla.kernel.org/show_bug.cgi?id=3452

