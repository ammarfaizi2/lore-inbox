Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280001AbRJ3RHP>; Tue, 30 Oct 2001 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280025AbRJ3RHG>; Tue, 30 Oct 2001 12:07:06 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:19603 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280001AbRJ3RG7>;
	Tue, 30 Oct 2001 12:06:59 -0500
Date: Tue, 30 Oct 2001 17:07:36 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Johan <jo_ni@telia.com>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Still having problems with eepro100
Message-ID: <38130000.1004461656@shed>
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan,

If you mean occasional lockups, which go away if you do ifdown / ifup,
then try the patch I posted Sunday - it forces one of the bug workarounds
on, which was dependent on eeprom by default. Also has a debug line
which writes out what it thinks the chip ID is, which activates
(or not) the other bug workaround. Alan put some or all of this
patch into the latest -ac; from his docs I couldn't tell whether
he put in the 'always use bug override' bit, and I expect not.
if you want to do it yourself, find where rx_bug is set, and just
set it to 1 the line afterwards, and try that.

Alternatively, try the intel drivers.

Alex

--On Tuesday, October 30, 2001 12:39:27 +0100 Johan <jo_ni@telia.com> wrote:

>
> Hello,
> Does anyone except me still having problems with the eepro100 drivers ?
>
> The network connection stalls and I'll get this message:
>
> eepro100: wait_for_cmd_done timeout!
>
> I am using the eepro100 drivers with my 100/10 card running in
> 10mbit and it works in windows.
>
> I have been trying all new kernels + the ac patches but nothing
> seems to work. The fun thing is that I only gets this problem
> when I am running XFree, is this just a weird coincidence?
>
> /Johan Nilsson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--
Alex Bligh
