Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270798AbRHSVfH>; Sun, 19 Aug 2001 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270799AbRHSVe5>; Sun, 19 Aug 2001 17:34:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:55267 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270798AbRHSVei>;
	Sun, 19 Aug 2001 17:34:38 -0400
Date: Sun, 19 Aug 2001 22:34:49 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: lists@sapience.com, Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <479225540.998260489@[169.254.45.213]>
In-Reply-To: <20010819104345.A11696@sapience.com>
In-Reply-To: <20010819104345.A11696@sapience.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene,

>  Perhaps the patch does this already, but if there are concerns about
>  pollution from the nasty outside is it possible to add a flag to /proc
>  to turn this on/off by interface - that way it could easily be limited
>  to only get influenced by the inside network rather than the outside.

No it doesn't do this, but:

Because it looks at inter-IRQ timing, the risk is mainly (as per
previous posting) the theoretical risk of being able to determine
that inter-IRQ timing from observation of the network(s) connected.
So an attacker sending packets at known intervals on one network
when interleaved with packets arriving at unknown intervals on
another network will not do them much good. Equally observations
made on packet timings on one network will be useless if those
packets are interleaved with packets arriving on another network.
As per previous posting, there is a theoretical risk, (magnitude
dependent upon environment) - hence the config option - but rather
smaller than the risk (say) if you are using a radio mouse & keyboard.

--
Alex Bligh
