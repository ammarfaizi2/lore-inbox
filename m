Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSCMFxd>; Wed, 13 Mar 2002 00:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSCMFxX>; Wed, 13 Mar 2002 00:53:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:35596 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292368AbSCMFxO>;
	Wed, 13 Mar 2002 00:53:14 -0500
Subject: Re: Iner Module Communications
From: Robert Love <rml@tech9.net>
To: vinolin <vinolin@nodeinfotech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02031311152001.00884@Vinolin>
In-Reply-To: <02031311152001.00884@Vinolin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 13 Mar 2002 00:53:39 -0500
Message-Id: <1015998820.856.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-13 at 00:45, vinolin wrote:

> Is it possible to perform inermodule communications between the LKM s?
> Any idea ?
> Please share with me.

You can call functions and touch data in other functions ... the kernel
image, even with modules, is one big flat monolithic model.

You will probably want to EXPORT_SYMBOL the functions and variables you
want to touch ... see other modules.  But basically you can access
anything that is exported once your module is linked.

Carefully consider _why_ you need "inter-module communication",
though... and design to those (hopefully proper) goals.

	Robert Love

