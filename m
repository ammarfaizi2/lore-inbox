Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268618AbTCCTja>; Mon, 3 Mar 2003 14:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268621AbTCCTj3>; Mon, 3 Mar 2003 14:39:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:59909 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268618AbTCCTj2>;
	Mon, 3 Mar 2003 14:39:28 -0500
Date: Mon, 3 Mar 2003 20:49:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Lerhaupt, Gary" <Gary_Lerhaupt@Dell.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] DKMS: Dynamic Kernel Module Support
Message-ID: <20030303194958.GA3847@mars.ravnborg.org>
Mail-Followup-To: "Lerhaupt, Gary" <Gary_Lerhaupt@Dell.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <20BF5713E14D5B48AA289F72BD372D680326F88E@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D680326F88E@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:07:03AM -0600, Lerhaupt, Gary wrote:
> I wanted to post a follow-up as I have seen only a few downloads of DKMS
> since my original posting and also given that the Linux Development Group
> here at Dell is very interested in feedback from the community.

Hi Gary.
I have made a brief look at the shell script.
It assume .o for modules, which is not true for 2.5.

When building a module it simply executes $MAKE - which is plain wrong.
As have been discussed in several threads you cannot reliably track
changes in CFLAGS etc. without utilising the kbuild infrastructure.

DKMS is also highly connected to the usage of /lib/modules/...
and naming of config files. It looks to me as it is very distribution
specic.

	Sam
