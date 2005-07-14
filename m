Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVGNG3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVGNG3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 02:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVGNG3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 02:29:14 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:63643 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262866AbVGNG3M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 02:29:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=De3A+u7JW0njuLKPbAkBztYdQnF8hmrh7hlMnqheR41Gy31RNN0AeL3H6jLwUgO5RY713xu+wBmUxrOGGIyNA8MudeBr0N5fe10fGZAToD5wTcOxzwvA0RBNOV/YW7mqtBjDu134Q3xKLC6M/rMWi0m3YEpJvbSZUFzK5u3Qjvg=
Message-ID: <4807377b05071323286963bf3a@mail.gmail.com>
Date: Wed, 13 Jul 2005 23:28:15 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Reply-To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>
Subject: Re: eepro100/e100 broken in 2.6.13-rc3
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20050714034954.52947263@laska>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714034954.52947263@laska>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru> wrote:
> symptom
> =======
> modprobe e100
> ifconfig eth0 <ip> netmask <netmask>
> 
> result:
> =======
> SIOCADDRT: Network is unreachable
> 
> There were no such error in 2.6.13-rc2

odd, both e100 and eepro100 are broken?  This might indicate something
wierd with the pci layer.  Don't know what might cause the Network is
unreachable...

please send lspci -vvv of the e100 device in question and any output from dmesg

added netdev in case someone has an idea there.
