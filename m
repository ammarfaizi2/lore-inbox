Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUDKQvr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUDKQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:51:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60428 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262416AbUDKQvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:51:44 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: List of oversized inlines
Date: Sun, 11 Apr 2004 19:51:34 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua> <20040411163255.GB6248@waste.org>
In-Reply-To: <20040411163255.GB6248@waste.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WeXeAOZ6GHh4gZB"
Message-Id: <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WeXeAOZ6GHh4gZB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 11 April 2004 19:32, Matt Mackall wrote:
> On Sun, Apr 11, 2004 at 07:05:49PM +0300, Denis Vlasenko wrote:
> > Below you may find a list of inlines which have multiple callers
> > and which compile to more than 39 bytes.
>
> Could you perhaps subtract out the size of a null function and include
> the product of size * uses?
>
> > Tool used to obtain this list will be published when
> > I will polish it a bit.
>
> I'd obviously like to add this to the scripts in -tiny.

Well, it's too ugly for words now. I shall work on it a bit.

Basically, you:

* untar linux tree into tree/, 
* make allyesconfig
  NB: I did not do this, I used my 'usual' config
* compile it with MEASURE_INLINES, saving
  make output in make_inline.log
* run 'process' script (get a list of inlines)
* run process2 (add functions to .c files)
* run make again, >make_test.log
* run process3 (file+line of errors)
* run process4 (comment out error lines)
  NB: BUG! sh 'read -r line' strips spaces
* run make again, no need to save space
* run process5 (calculate size using nm)
* run process6 (sorting)
* run process7 (throw away 1 caller inlines)
  NB: needs rewriting in e.g. python, outrageously slow
--
vda

--Boundary-00=_WeXeAOZ6GHh4gZB
Content-Type: application/x-tgz;
  name="inline_size.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="inline_size.tar.gz"

H4sIAJx1eUACA+1Z3XPaOBDnFf8VW8eJIS3xF4ZLMvDUu9e+9C3NUNcWoIuROdskbQn/+0myLGRw
k85cA7k7KzNYWml39bW7v1UwiTFBkwx/R1brhYpt9+2h79MvL7tfXnds2xu4Q3fg0nGOaw+9Fvit
A5RVlgcpQCtNkvypcc/1/0sLVs5/mSYhyjL3l58/PVz/x+fv9P2hOP+B4zouHe/5vtMCuzn/Fy8n
b6wvmFjZXNOWKZrir6M8RcjStOmKhDlOCARRNMlRlne6sNaAFhTOE9DvExyBuD3G2tlM7A4j0UHA
mp3uNWz0p8Y71fH2swzuDsO751m8PZafYOrXMP0Em1/LVjJuNG2thUEOi+AOTQq+/kWczDQmTtvA
I93dJI4mUxyjkWlqD3NagRQFETASsPOg+sJ4FSH4c0XuriFK+HzwFNj5gG6U/Dq8GdEmr15DPkdE
a9eMKrvqF4VIVK5oo8N4rBvFBdnya+0pbmttztojQiFQslyHmIOqvV6zIl6K5osTnxP4+OH9hyvI
7vCSL3iOM+iwPXkn9qQLD0EGQcx27BvMAxLFKNrZn4ru8l4zOpWj789B6I8Sguj58XP6P/h/78D+
3/ZsX/h/13doLGj8/1H8v/ROzCqYa4JP2iPMUrSE3u9gXoRXN3bv8vbtFaA0TdIryJMEboLe99tz
CNLZaoFInlEiyNDx2aQixlKmy/1dVY8rFWUoAjOzpPSLc8OyzEqXBdasKtLjIltN+YX23z80/nP9
Ev/79M/j9t8fNvZ/VPyXL5Yji/5YhnERKnAwRYvkHk3YrckkJIyTMIhBhHyniJzZHE9zpTck+chR
2kwCbzJ/IGIztW1GeQQF/fRSPpTDHQVHUHE6MJTj1OAYyzIYj17QipnwaiFXiHB0ODuryOvNkJDI
lLUVRg4C2ijOkKqn1EJRQputz+h06Oet0+1qJROMDbqLvLm4B1YvF7uDCbfu7AeIkG95HTRkHS8F
CTmuK7tBbKh6B2AfFwLflqzYln0sKNeh4LuCVuxnxn+prv808Hq9/t8/sP+3h7ZX5v+u74n832v8
/4H9/xSTCJj3p0YfLBCY5xdJgb/Wuy5HOhrhBguzH5+5nEgWkiTwowkfy7TSpLQsSXNh3dLLMZUj
c5t7mpxKk7R0ZGvVcMCIkAOfZMXtRXg6ZT4Y7K8GH9RjtVKOcMpVr8eEFL5xq1p6wZNlikk+Bf00
g9PfMJxmn4guGJlEVmc6dVWY1pZcCsv+sML7sV9elXugG9t+uQU6X0/pEhkEBmay/xz91tj/4ND2
79qutP+B4xf2bzf2f4T8r7xURdpFzZTZ2yOsCP6LXTrWrWRxsqlmaaWh02Stkr1NePYocjouqUne
XmX8Hx7a/geOfP8feOL9Z+g29n8E+xfXIUxWZPsEtNZwNQaHQKqBl0WsGwPfsuBVRC6aBglCWBAw
C8yYp0Y8iEkWmghIZ+JJnYq2eFcbnc11NZNbl9I2+m6eqHTxdJFUchxlnJjxhqMBpxxUDeb9bUCP
9SoTX3lbpDT8+4XO/k4+ZG/Xf10kkzuhvH8cZ1hj/60D27/jeKX9+0N76DD77zf2f7z33+JOPPkC
/BCkBJPZFZjKkD9oC2cQoWWKqDAa9jsRCuMgpTUqe/tyWyjYfQ5WqJVXX67zXNH5uQIt9Mx6Ui0d
rNfI65ZIRNHt1c7IqwKiLRra+1eeBnX/4WOPWo8QriiWiky6C72p2/MKYlUgjIU1zhVpKmlfklOQ
uIBeCFvMxsniWO7pUMfkCjK8wHRn4m8814hq19uX663O+fJybxN2VI53w0cD7prSlKY05bWWvwH0
OrbRACgAAA==

--Boundary-00=_WeXeAOZ6GHh4gZB--

