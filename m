Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWFNFDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWFNFDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWFNFDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:03:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5332 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964854AbWFNFDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:03:16 -0400
Date: Wed, 14 Jun 2006 01:03:01 -0400
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614050301.GA10140@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Chase Venters <chase.venters@clientec.com>,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse> <448F967A.8070801@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F967A.8070801@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 12:54:18AM -0400, Brice Goglin wrote:

 > What about GPL modules that don't want to get merged ? I don't know any
 > such module that could use this API. But at least there are some webcam
 > drivers that don't seem to want to be merged (I don't know why).

AIUI, many modern webcams export their data as jpeg streams.
Existing userspace expects the kernel to feed it raw data.
To keep existing userspace working, the out-of-tree drivers (such as ov5xx)
are doing format conversion in kernelspace so that the stream now goes..

camera -> jpeg -> kernel -> raw -> userspace

in-kernel format conversion is somewhat nasty however, so the
out-of-tree drivers seem to be staying that way.

		Dave

-- 
http://www.codemonkey.org.uk
