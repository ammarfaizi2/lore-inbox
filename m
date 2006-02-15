Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945926AbWBOMsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWBOMsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWBOMsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:48:45 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:27804 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945926AbWBOMso convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:48:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gQ/vilQa+0Gczxhz9qDZ6cnjgxS5gaAsjYXvL1C6cB+MeT7HmAR+koGstvjchB+fi7pKf2mVbQNbz8RAFBYW4YxDxhN0I3D6U0I1vJZ8bNw1TP9eRRsReQdMrIN6+9R4OREfec0DF1Hu0NC6GAAqMM9SLMNMqST2LW3A/8L0lxE=
Message-ID: <9871ee5f0602150448j487dcd6nb20114bbd42a1dfa@mail.gmail.com>
Date: Wed, 15 Feb 2006 07:48:42 -0500
From: Timothy Miller <theosib@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: HELP: Problem with radeonfb setting wrong resolution
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43F2BCF6.805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
	 <1139955612.7903.46.camel@localhost.localdomain>
	 <9871ee5f0602141817p12617034o7f118710775cc73c@mail.gmail.com>
	 <43F2BCF6.805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Antonino A. Daplas <adaplas@gmail.com> wrote:

>
> Looks like an EDID problem.  Can you change #undef DEBUG to #define DEBUG
> in drivers/video/fbmon.c and post your dmesg again?

You were right.  It's an edid problem.  I disabled DDC/I2C for Radeon,
and the problem cleared right up.
