Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRBFIqc>; Tue, 6 Feb 2001 03:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRBFIqW>; Tue, 6 Feb 2001 03:46:22 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:58384 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S130820AbRBFIqI>; Tue, 6 Feb 2001 03:46:08 -0500
Date: Tue, 6 Feb 2001 05:46:47 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: different IRQ settings for different MPS settings?
Message-ID: <20010206054647.C692@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With a MPS setting of 1.4 USB doesn't work on me; it timeouts,
constantly.  With MPS setting of 1.1 everything is OK.

a dirty diff of lspci -vvvxx gives

     62c62
     <       Interrupt: pin D routed to IRQ 5
     ---
     >       Interrupt: pin D routed to IRQ 19
     77c77
     <       Interrupt: pin D routed to IRQ 5
     ---
     >       Interrupt: pin D routed to IRQ 19
     103c103
     <       Interrupt: pin A routed to IRQ 11
     ---
     >       Interrupt: pin A routed to IRQ 18
     124c124
     <       Interrupt: pin A routed to IRQ 5
     ---
     >       Interrupt: pin A routed to IRQ 19
     140c140
     <       Interrupt: pin A routed to IRQ 10
     ---
     >       Interrupt: pin A routed to IRQ 16
     157c157
     <       Interrupt: pin A routed to IRQ 12
     ---
     >       Interrupt: pin A routed to IRQ 17
     186c186
     <       Interrupt: pin A routed to IRQ 10
     ---
     >       Interrupt: pin A routed to IRQ 16

(I've attached both lspci -vvvxx's, so you can diff -u that if
you want).

My question(s) is(are) is this a known bug, is this correct
behaviour, am I missing something, and why is USB the only
subsystem affected.

Phew.

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
Se Deus =E9 amor e o amor =E9 cego, Ray Charles =E9 Deus?

--neYutvxvOLaeuPCA
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci_mps1.1.gz"
Content-Transfer-Encoding: base64

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

--neYutvxvOLaeuPCA
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci_mps1.4.gz"
Content-Transfer-Encoding: base64

H4sICN+xfzoAA2xzcGNpX21wczEuNADtml9z2jgXh6/DpzjvXTLgRpb/YJgmM0Bolm1oWUjS
ncnkQtgieAo2Y5su2U//HskYjA3EoWy76WwGEjuWjmTp95xzJJuQOiHvCPzmhxEMA9d54nW4
7zTglttjz5/4Ty4PK9Dx7Hdwf2vRllnTGudmTV/AQ2PmTyY+9PqfVU1bPMJpwL+BrZ+VTlq+
FwX+pA6d888KdPm0DM152GVhxIMyDGbcbj3bEy4vfel8ulfg/rox8Hx/pkCPBe0gUGAQ8dnM
9Z7wqN3vK/ABazdpUymdDCIWzcM6tNisDKbZHf+twN3Vh3WRlY2r9v2gfXMx5Y47n8LlbWPo
B5EC71cHXXlQhsu4jfc9/FMundywiHv2cx1I6aTPn1zfA1IXnfWDZ2AROCT+gVONKkM3qsAs
4CMe2WM2nPAzeAjdv/mFqXcfcSzYjA3diRvhQNbhgZFHaFz34BsPQmGXvsM2VrfU/+NCU2HQ
bOCN6WgY7+mLAn3szsVCrSwoFm350ynzHFmWiKKKsKfkyr/3fI9f5tq3sf2e/xcPoMs89sSn
3IvWnUH7HybsCQv2uu3W5CsO4aCDv1T8UmxovmjNgwCrXJBpQ5Q5vSJKBS9X8HLlShv7kfhj
+xNHOUvd1xURhZW2J8ZHGOUT7PzVwGYTfhFfKxEcYmKCqkJNFQfiQ0AlwCiqShyLj5kciE9J
FXWs5blD0td2fUpU1ClUdF1Hy9RhBeqIGyIqstVrdQqhZdSsTbK69z3tvBf4Ai8xyYjYLPCf
FHckmnj45AdTNgGH277DHzPYlX8AduVjYqdsYtcUTc0Cd8qC5wtCKhDibXqOPFPxbI4WHNcT
Spfn3FYmcfULrI0DAEM+dj1nNfKC1xF+FUnuaDQqnSyBzhR09BhuxTFH8qd00kvRDdPttapJ
rWpSqykvtSKcEBwZN3pOxvST3xkg4Tj4OEvLMbns85BH6fHOgGsdBm75h4JrgWUAqQp5agQo
TWjQU+CqK3D34KPG5WCUB9fRxX8dac+pyuNqYXCt/dTaK3CrCC7OUrGYaJkrZgfzGU7RwJ9H
42VEpBQHdDAfhs/I4fRFS+cN6TAiXzYfa+i4aJf/+Yiq7EF7LRdLOnmruvTzhCaKUddysdZ+
/pU+u7Cfl33ZLpci7SzlokLnqg2uhxMyYvZuxeC0QTxvsoKUiErO1q7dYvCwLDDgdg96gdv7
Gd59UwLl40lAo6usSpd3AzMsH4rEyhZJVZw9qWY+eXoLyUsVtZT4wJoUNUob53Tl0uhG8nKI
qFUcp1fUyYp6V+XRKCdqCneDJiyVN+HBTlXf/YY+S5TN61nMqLj8uOkG77yvnv+Xh+nLN9fm
QGrUqKtU03+20I/o6zRaAZvZYw4T1+MgZI3ZKmYnwkkE81mEGY7rwRUEGC64I31+/w9Qa7v5
0Fd8aDTPx4E5wg/lQ7NEakBSTl+NRafJ8Gsdhw/9haIUEa2BpoNKi+cIhkxk0nxo//Hx7+LD
+o+PQnxYLxQ9Eh/6KzaWckl0o9XrLHNojWzbVVLWulfeQAKUEaNp/fvFaFSlGOUnTmZWp9t2
Yg4R4yvrZMVovqTkRIw2LugSnzplYQhh5Ac47GCnvHcv8KduyNcifV5KlBJqGrEWSWY9t6tO
zoXrjqb9Ut4756kbWU9tpfdPNz21vfLU1uOqlJop5azXA/q6FM2W0rfZ0rKlrG22shHEWffL
TBUzNrZ/a9ntX8/3lG1bwCq1PqKR9mLGPMl1/3NXWHg/91CC7pPHnUt4cNxQVHIeVw1/zMcu
Y5+7UH+2uzCYCFPCOTgbsYvQJGJsWftgHLITStXU9q0q9njWx9Zm7HLsLOJObeN02RcNgcu5
C2OXuxgue5i4CwfdxQc34F/wC6eddrsNqlbTz+rI+YKFSHgYBXMxCWEOdIvgfa7yO+zLw+d8
flfMzJt7lrLPX8Bp1SBeCFPXq+CwEHnMFmeFssCcb6nteDZTI1QvBCf9uOF4Nk0U5NvcQqqu
H0xqeT+p5ZjU8veQqttCkTSGMnnEEmO6TDS3Zpm6LLQmjWapOySwp/qSI1XftYQzJKmYDesx
qRxJbUdjHng82gjmWsuf4tosQN/OIhkR7BoxmkJ5TRby2z/hQaDjezydZaYQzRtoSQOCjbhJ
VOxX+PMGTZ6j1V8quMMpNciK1uT4YFrNnZkAT+35UWsPkkbRkPv6iLuM0xmQHfsgkMv7QS6/
BuTybpCHVQGPYcjEPBVy1xk6zYOs4nCnouGxQE71JQdyPl4vP/GeKP5mMcgjBLk7n0SukC0D
NndcfwPoVsCRw28cbtgwhEETbvDkf9Du3qmxu5bpubUJ8Wal1q1uobYHzbjqPZvMtz1dUd7s
1jqcpqg11jH2ZUKruwndv+v4z2BytIUslY93aBI7koXs8rUBdblnQTceNSEmL+0gHoJJ3Bda
3RbvdmJiy05iTT3BRMW0cTaPkjyxACIFyLhmUy5mHH738bprf/2lsNit7fWq0Hqz0q5uk7aQ
c22rtF/eMjlY2rJOYWmn2ikRNX4TDSWEip7OUJribYu0uLsMDxdwHbDZ2LWT3cMuVrjGfF2+
VhULXctsr6PNzOprhykXG/I8obLE4s/O6Y4cHHSyjg7W967AzB0rsGqRt+NUs7sr19MLb6+Y
Hzd2hVI2jKI2rO6RNmgO8BXlH7NBk+3pKPMOovo97yAmZdHglgpUOio6lOu83JNxsYqLHYCW
T1VXr/Wl3u5xUlHZMQ5yVHFfsMHR6JWpqlyqlkr/B1CHc7AzKwAA

--neYutvxvOLaeuPCA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
