Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268164AbTBSJnl>; Wed, 19 Feb 2003 04:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268170AbTBSJnl>; Wed, 19 Feb 2003 04:43:41 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:51382 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268164AbTBSJnj>; Wed, 19 Feb 2003 04:43:39 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Meino Christian Cramer <mccramer@s.netic.de>, wli@holomorphy.com
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Date: Wed, 19 Feb 2003 10:52:47 +0100
User-Agent: KMail/1.5
Cc: efraim@clues.de, linux-kernel@vger.kernel.org
References: <20030219071932.GA3746@clues.de> <20030219073221.GR29983@holomorphy.com> <20030219.095905.92587466.mccramer@s.netic.de>
In-Reply-To: <20030219.095905.92587466.mccramer@s.netic.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302191052.47663.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is becoming a FAQ!  Did you enable the console in your .config?

CONFIG_VT=y
CONFIG_VT_CONSOLE=y

Most likely you chose to compile the input system as a module, which
caused the console options to be autohorribly deselected.  Just say 'y'
for the input subsystem, at which point the console options will reappear,
letting you select them.

I hope this helps,

Duncan.

On Wednesday 19 February 2003 09:59, Meino Christian Cramer wrote:
> From: William Lee Irwin III <wli@holomorphy.com>
> Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
> Date: Tue, 18 Feb 2003 23:32:21 -0800
> Message-ID: <20030219073221.GR29983@holomorphy.com>
>
> Hi,
>
>  I have the sam eproblem here, but ACPI is definetly not configured...
>  Any idea else ?
>
>  Thank you for any help in advance ! :O)
>
>
>  Kind regards,
>  Meino
>
> wli> On Wed, Feb 19, 2003 at 08:19:32AM +0100, Alexander Koch wrote:
> wli> > I am experiencing problems getting certain 2.5.60 and
> wli> > 2.5.61 and also 2.5.62 to boot. One 2.5.60 is working,
> wli> > the others are just doing something as I only see the
> wli> > Uncompressing... and then nothing is happening at all
> wli> > except my hard disc doing something which is not booting,
> wli> > I feel. I fail to remember what the difference was between
> wli> > the two versions of 2.5.60 (one running, the other is not).
> wli> > Any ideas/hints on what this is?
> wli>
> wli> Do you have ACPI in your .config? Various ppl have been having
> wli> issues resolved when ACPI's deconfigured lately. Breaking out an
> wli> early printk patch of some flavor should probably help get some
> wli> boot logs out so you can debug if you care to do so.
> wli>
> wli>
> wli> -- wli
> wli> -
> wli> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in wli> the body of a message to majordomo@vger.kernel.org
> wli> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> wli> Please read the FAQ at  http://www.tux.org/lkml/
> wli>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
