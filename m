Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757453AbWKWURX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbWKWURX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbWKWURX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:17:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:61798 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1757453AbWKWURW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:17:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfJoZxtwcLKOlmJcAHVA7DotqWe2kT7b+AGsX2RcUViBHlrcrjOXCc2j2KfrV9noogLLA7JfRYIlRMaDlPE1tVIDdC/hp91OAysatK147RmZbb1yz598RbG59GQhad/qFtWgi3U6JxYMeDJqGLofcHZ4WPxLLJVp2dfO2f46RhY=
Message-ID: <a769871e0611231217w1a6a9d1ag7e708eaf5f991981@mail.gmail.com>
Date: Thu, 23 Nov 2006 21:17:21 +0100
From: wbrana@gmail.com
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] snd-hda-intel: fix insufficient memory
Cc: linux-kernel@vger.kernel.org, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>
In-Reply-To: <20061122120422.7f1f96fe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
	 <20061121224613.548207f9.akpm@osdl.org>
	 <a769871e0611220919q62ccdb5k5548062300e35376@mail.gmail.com>
	 <20061122120422.7f1f96fe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Andrew Morton <akpm@osdl.org> wrote:
>
> Are the new settings of 64kb and 1MB sufficient?  If not, by how much must
> they be increased, and why?
>
>
Default size should be increased to 256 kB to allow same buffer length
 ( 16384 frames )
with 2 and 8 channels or same buffer time with 48 kHz/16 bit and 96 kHz/32 bit.
Maximal size should be at least 4096 kB, which should't limit buffer
time with any sound
like 192 kHz/8 channels/32 bit.
