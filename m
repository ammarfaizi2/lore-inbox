Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVINR2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVINR2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbVINR2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:28:19 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:3215 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965255AbVINR2S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:28:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5ZBHc5DQ3VslUQ+GVGjO44iRaNWnAm7xoIqCD5NvDrWOgfLHptseBZ62NVzPwcwEVl8M2HJsHbfPk3SdJqPP7y194seVNlsR2PJZUsgIIY2V6b5lj28ExQ/nSI3TBW7yLmxNx+g4f8tBnjFMBqqYMjHnfp+T0IlW8F/+w0S710=
Message-ID: <d120d5000509141028252d060c@mail.gmail.com>
Date: Wed, 14 Sep 2005 12:28:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [patch] hdaps driver update.
Cc: Robert Love <rml@novell.com>, Mr Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050914161622.GA22875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1126713453.5738.7.camel@molly> <20050914160527.GA22352@kroah.com>
	 <1126714175.5738.21.camel@molly> <20050914161622.GA22875@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Greg KH <greg@kroah.com> wrote:
> 
> No, if you have that .owner field in your driver, you get a symlink in
> sysfs that points from your driver to the module that controls it.  You
> just removed that symlink, which is not what I think you wanted to have
> happen :(
> 

Hmm, i have a concern WRT to that link - it is only present if driver
is registered from a code compiled as a module. If driver is built-in
THIS_MODULE is NULL and symlink will not be created. Hovewer
/sys/modules/<module> is created regardless of whether module is a
module or built-in. So the behavior is inconsistent and it looks like
a replacement is needed.

-- 
Dmitry
