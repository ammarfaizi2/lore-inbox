Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTAPNXJ>; Thu, 16 Jan 2003 08:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbTAPNXJ>; Thu, 16 Jan 2003 08:23:09 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:13785 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S267070AbTAPNXI>; Thu, 16 Jan 2003 08:23:08 -0500
Message-ID: <3E26B344.2030400@oracle.com>
Date: Thu, 16 Jan 2003 14:27:32 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Paulo Andre'" <fscked@netvisao.pt>
CC: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: radeonfb almost there.. but not quite! :)
References: <20030115181633.3e058dfd.fscked@netvisao.pt>
In-Reply-To: <20030115181633.3e058dfd.fscked@netvisao.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Andre' wrote:
> Hi James,
> 
> First of all, thanks a lot for the amount of work you've been putting
> into the fbdev layer of the linux kernel.
> 
> A few weeks ago I've emailed you about some issues with the radeonfb
> driver on late 2.5 kernels but didn't get any reply from either you or
> Geert. So I'm trying again, providing the (hopefully necessary) input
> for sorting this issue.
> 
> I have an ATI Mobility Radeon 7500 card on a Fujitsu E-7110 laptop and
> the framebuffer console works fine on 2.4 kernels. Not surprising that
> it doesn't work that fine on 2.5 though, considering the new API and all
> the porting that's going on. I compile the radeonfb driver in, selecting
> all the appropriate options as I go along (particularly the Framebuffer
> Console) and upon boot it does detect my card and fb driver just fine,
> along with the appropriate resolution (1400x1050). Here's the snippet
> from 'dmesg':
> 
> radeonfb_pci_register BEGIN
> radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
> radeonfb: probed DDR SGRAM 32768k videoram
> radeon_get_moninfo: bios 4 scratch = 1000006
> radeonfb: panel ID string: Samsung LTN150P1-L02    
> radeonfb: detected DFP panel size from BIOS: 1400x1050
> radeonfb: ATI Radeon M7 LW DDR SGRAM 32 MB
> radeonfb: DVI port LCD monitor connected
> radeonfb: CRT port CRT monitor connected
> radeonfb_pci_register END
> 
> Right after detecting this, it tries to display the framebuffer console
> but all I can see is garbage, impossible to read anything, even though
> it keeps booting as usual and I can even (blindly) login and start X
> (though it's all hardware, not framebuffer).
> 

Radeonfb works better for me in 2.5.58, same card but on a
  Dell Latitude C640 - 1024x768 though, and xclk=16600.

I say "better" and not simply "works" because

  - the gpm cursor positioned on characters shows different ones
     (eg. hovering on a 'd' it shows a highlighted 'B')
  - the pre-penguin display is garbage. The console though gets
     to recover right after the penguin display

Definitely usable anyway :)

--alessandro

  "And though it don't seem fair, for every smile that plays
    a tear must fall somewhere"
        (Bruce Springsteen, "The Price You Pay", live 31/12/1980)

