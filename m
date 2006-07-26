Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWGZPne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWGZPne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWGZPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:43:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37083 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751675AbWGZPnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:43:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cwjE70woGx3Jy4xgoWbAauuAhnG03JmMn7OyEt6nU3FZn+EMHACzTSmGUPt7lw8Fhd6J4N6XxNQNbfCWbqI/acKQqBdS/iflzjPWVK1yOJBQvhuRhU4c3T+zriK9nNjpCTSGT07DmUsF0c4TYD1y52+8z5cOHkb7Ns+8McGw8DA=
Message-ID: <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
Date: Wed, 26 Jul 2006 18:43:30 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: Re: [patch] slab: always follow arch requested alignments
Cc: "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Manfred Spraul" <manfred@colorfullife.com>
In-Reply-To: <Pine.LNX.4.64.0607260823160.5647@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
	 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
	 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
	 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0607261529240.20519@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0607260823160.5647@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: 1d1a4b77c924ddcc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> We intentionally discard the caller mandated alignment for debugging
> purposes.

Disagreed. The caller mandated alignment is not a hint. It is the
required minimum alignment for objects.

On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> And it changes the basic way that slab debugging works.

Look at kmem_cache_create, we turn off debugging for both caller and
architecture mandated alignments already and the only reason we are
not doing it for Heiko is because the architecture recommended default
alignment is so large.

                                      Pekka
