Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVCPRgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVCPRgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVCPRgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:36:51 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:19290 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262706AbVCPRgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:36:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mGkKp72USdKS7vfgq32g6K2PTzr9d72EZhTnD5jLxq0ug+pGSGvSdaQsmhoIw3PDC/wQE7QppHXHCyD92JtuA3xl7jeiAkIyIXwy2RUwivLovOR1rtYB8CA3bkZu3spwqnNaFWRf9Fi3sCoVwVTVaWaI/bb9TDRt7MqCGcyvmHw=
Message-ID: <d120d50005031609363906360d@mail.gmail.com>
Date: Wed, 16 Mar 2005 12:36:43 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: psmouse et al and mousedev dependancy
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4238642F.9080701@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4238642F.9080701@tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Mar 2005 19:51:59 +0300, Michael Tokarev <mjt@tls.msk.ru> wrote:
> A quick (hopefully) question.
> 
> When mousedev is compiled as a module, loading psmouse or usbhid
> modules does not enable the mouse, one have to load mousedev too.
> The same is true for keybdev and actual keyboard drivers.
> 
> Why not add this dependancy explicitly in psmouse et al modules,
> something like (pseudocode):
> 
> #if CONFIG_MOUSEDEV==m
>  request_module(mousedev);
> #endif
> 
> , or, to "use" some symbol in psmouse.ko which is defined in mousedev?
> 

Not everyone uses mousedev (evdev, tsdev, joydev) so they are not
loaded by default. It is actually hotplug scripts' task to load proper
interface module after a new input device has been discovered.

-- 
Dmitry
