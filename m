Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264582AbRGLOEK>; Thu, 12 Jul 2001 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264752AbRGLOEA>; Thu, 12 Jul 2001 10:04:00 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:20098
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S264582AbRGLODo>; Thu, 12 Jul 2001 10:03:44 -0400
Date: Thu, 12 Jul 2001 07:03:46 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: IPsec in Kernel??
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A01C65051@dcmtechdom.dcmtech.co.in>
Message-ID: <Pine.LNX.4.33.0107120544310.13780-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Nitin Dhingra wrote:

> Is there any possibility that IPsec will be provided in
> the kernel ?

The maintainers won't accept code from anyone in the US for fear that
export regulations may tighten again retroactively, so any merge into the
kernel would require a seperate maintainer either to maintain the fork,
and/or to constantly merge in new changes from the original freeswan
project.

The current in-kernel portion of freeswan doesn't get along well with
advanced routing, and doesn't take advantage of SMP, so I'd be rather
disappointed if it got forked and merged in its current form.

Some things that would be nice:
 integration with advanced routing
 /proc interface so connections can be added on the fly
 module-only option (freeswan's latest snapshots seem to have this)
 take advantage of SMP
 implement AES
 use of kernel crypto patch / openssl for userland rsa stuff
 move all non-optional parts of the updown scripts into the ipsec program,
  a la openbsd where the shell script portion isn't hundreds of lines for
  one tunnel.
 no bloat (a 3.5 meg ipsec module doesn't seem very reasonable)


justin

